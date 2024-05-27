import 'dart:developer';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String googleApiKey = 'YOUR_GOOGLE_API_KEY';

  static Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      log("location denied");
      LocationPermission ask = await Geolocator.requestPermission();
      if (ask == LocationPermission.denied || ask == LocationPermission.deniedForever) {
        log("location permission denied after request");
        return 'Location permission denied';
      }
    }

    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    log("Latitude=${currentPosition.latitude}");
    log("Longitude=${currentPosition.longitude}");

    // Using geocoding package
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentPosition.latitude,
      currentPosition.longitude,
    );

    String address;
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      address = '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
    } else {
      log("No address found");
      address = await getGoogleAddress(currentPosition.latitude, currentPosition.longitude);
    }

    if (isWithinDelhiNCR(currentPosition.latitude, currentPosition.longitude)) {
      return address;
    } else {
      return "Sorry! We are currently unavailable at your location";
    }
  }

  static Future<String> getGoogleAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        return data['results'][0]['formatted_address'];
      }
    }
    return 'No address found';
  }

  static bool isWithinDelhiNCR(double lat, double lng) {
    // Example boundaries for Delhi NCR (not precise)
    const double northLat = 29.0;
    const double southLat = 27.0;
    const double eastLng = 77.5;
    const double westLng = 75.5;

    if (lat <= northLat && lat >= southLat && lng <= eastLng && lng >= westLng) {
      return true;
    } else {
      return false;
    }
  }
}

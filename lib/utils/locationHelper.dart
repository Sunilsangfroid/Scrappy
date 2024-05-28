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
      log("Address: $address");
      if (isWithinDelhiNCR(place)) {
        return address;
      } else {
        return "Sorry! We are currently unavailable at your location";
      }
    } else {
      log("No address found");
      address = await getGoogleAddress(currentPosition.latitude, currentPosition.longitude);
      log("Google Address: $address");
      return address;
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

  static bool isWithinDelhiNCR(Placemark place) {
    final List<String> validCities = ['Gurugram','Kairana', 'Noida', 'Greater Noida', 'Faridabad'];
    final String? state = place.administrativeArea;
    final String? city = place.locality;

    if (state == 'Delhi' || validCities.contains(city)) {
      return true;
    } else {
      return false;
    }
  }
}

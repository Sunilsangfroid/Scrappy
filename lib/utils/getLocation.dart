import 'package:flutter/material.dart';
import 'locationHelper.dart'; // Import the helper

class LocationServices extends StatefulWidget {
  const LocationServices({super.key});

  @override
  State<LocationServices> createState() => _LocationServicesState();
}

class _LocationServicesState extends State<LocationServices> {
  String _address = 'Unknown';

  Future<void> _getCurrentLocation() async {
    String address = await LocationHelper.getCurrentLocation();
    setState(() {
      _address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geolocator"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Grab Location"),
            ),
            const SizedBox(height: 20),
            Text('Address: $_address'),
          ],
        ),
      ),
    );
  }
}

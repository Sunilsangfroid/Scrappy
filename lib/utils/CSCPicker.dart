import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:scrappy/pages/serviceSelector.dart';

class CSCPickerScreen extends StatefulWidget {
  const CSCPickerScreen({Key? key}) : super(key: key);

  @override
  State<CSCPickerScreen> createState() => _CSCPickerScreenState();
}

class _CSCPickerScreenState extends State<CSCPickerScreen> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  final List<String> validStates = ['Delhi'];
  final List<String> validCities = ['Gurugram', 'Noida', 'Greater Noida', 'Faridabad'];

  void _confirmLocation() {
    if ((stateValue != null && validStates.contains(stateValue)) ||
        (cityValue != null && validCities.contains(cityValue))) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelectService()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Unavailable Location'),
          content: const Text('Sorry! We are currently unavailable at your location.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select your location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CSCPicker(
              defaultCountry: CscCountry.India,
              onCountryChanged: (country) {
                setState(() {
                  countryValue = country;
                });
              },
              onStateChanged: (state) {
                setState(() {
                  stateValue = state;
                });
              },
              onCityChanged: (city) {
                setState(() {
                  cityValue = city;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmLocation,
              child: const Text('Confirm Location'),
            ),
          ],
        ),
      ),
    );
  }
}

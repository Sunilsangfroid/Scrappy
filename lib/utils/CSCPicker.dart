import 'package:flutter/material.dart';

class CSCPickerScreen extends StatefulWidget {
  const CSCPickerScreen({super.key});

  @override
  State<CSCPickerScreen> createState() => _CSCPickerScreenState();
}

class _CSCPickerScreenState extends State<CSCPickerScreen> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  // Dummy data for countries, states, and cities
  final List<String> countries = ['India'];
  final Map<String, List<String>> states = {
    'India': ['Delhi', 'Haryana', 'Uttar Pradesh'],
  };
  final Map<String, List<String>> cities = {
    'Delhi': ['Delhi'],
    'Haryana': ['Gurugram', 'Faridabad'],
    'Uttar Pradesh': ['Noida', 'Greater Noida'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedCountry,
              hint: const Text('Select Country'),
              items: countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCountry = newValue;
                  selectedState = null;
                  selectedCity = null;
                });
              },
            ),
            if (selectedCountry != null)
              DropdownButton<String>(
                value: selectedState,
                hint: const Text('Select State'),
                items: states[selectedCountry!]!.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue;
                    selectedCity = null;
                  });
                },
              ),
            if (selectedState != null)
              DropdownButton<String>(
                value: selectedCity,
                hint: const Text('Select City'),
                items: cities[selectedState!]!.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCity = newValue;
                  });
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCountry != null && selectedState != null && selectedCity != null) {
                  Navigator.pop(context, {
                    'country': selectedCountry!,
                    'state': selectedState!,
                    'city': selectedCity!,
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Incomplete Selection'),
                      content: const Text('Please select country, state, and city.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

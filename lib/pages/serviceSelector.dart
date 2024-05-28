import 'package:flutter/material.dart';
import 'package:scrappy/pages/buyer_page.dart';
import 'package:scrappy/pages/seller_page.dart'; // Import buyerPage class

class SelectService extends StatefulWidget {
  const SelectService({Key, key}) : super(key: key);

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  Future<void> getCurrentLocation() async {
    // Your existing code for getting current location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Selector Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

             // Add some space between buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to buyer page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyerPage()), // Use BuyerPage class here
                    );
                  },
                  child: Text("Buyer"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to buyer page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellerPage()), // Use BuyerPage class here
                    );
                  },
                  child: Text("Seller"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

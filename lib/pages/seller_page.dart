import 'package:flutter/material.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({Key? key}) : super(key: key);

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  String? _selectedItem;
  TextEditingController _quantityController = TextEditingController();
  bool _isCorporateSeller = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedItem,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              items: [
                DropdownMenuItem(child: Text('Paper'), value: 'paperSell'),
                DropdownMenuItem(child: Text('Hardboard'), value: 'hardboardSell'),
                DropdownMenuItem(child: Text('Newspaper'), value: 'newspaperSell'),
              ],
              hint: Text('Select Material'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isCorporateSeller,
                  onChanged: (value) {
                    setState(() {
                      _isCorporateSeller = value!;
                    });
                  },
                ),
                Text('Corporate Seller'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

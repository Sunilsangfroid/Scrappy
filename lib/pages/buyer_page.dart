import 'package:flutter/material.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({Key? key}) : super(key: key);

  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  String? _selectedItem;
  TextEditingController _additionalInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyer Page"),
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
                DropdownMenuItem(child: Text('Paper'), value: 'paper'),
                DropdownMenuItem(child: Text('Hard Board'), value: 'hard_board'),
                DropdownMenuItem(child: Text('Newspaper'), value: 'newspaper'),
              ],
              hint: Text('Select Option'),
            ),
            SizedBox(height: 20),

            TextField(
              controller: _additionalInfoController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Additional Information',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _additionalInfoController.dispose();
    super.dispose();
  }
}

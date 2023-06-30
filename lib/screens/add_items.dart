import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('products');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  bool _isButtonEnabled = false;

  void _checkButtonAvailability() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _imageController.text.isNotEmpty;
    });
  }

  Future<void> _addItem() async {
    final Map<String, dynamic> productData = {
      'name': _nameController.text,
      'price': _priceController.text,
      'image': _imageController.text,
    };
    await _database.push().set(productData);

    // Clear the input fields after adding the item
    _nameController.clear();
    _priceController.clear();
    _imageController.clear();

    // Show a snackbar or any other necessary action
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (_) => _checkButtonAvailability(),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              onChanged: (_) => _checkButtonAvailability(),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
              onChanged: (_) => _checkButtonAvailability(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _addItem : null,
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

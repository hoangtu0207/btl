import 'package:flutter/material.dart';
import 'database_helper.dart';

class EditItemPage extends StatelessWidget {
  final int id;
  final String currentName;
  final TextEditingController _nameController = TextEditingController();

  EditItemPage({required this.id, required this.currentName}) {
    _nameController.text = currentName;
  }

  void _updateItem(BuildContext context) async {
    if (_nameController.text.isNotEmpty) {
      await DatabaseHelper().updateItem(id, _nameController.text);
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật mục thành công!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Lỗi'),
          content: Text('Tên không được để trống'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
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
        title: Text('Sửa nội dung'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updateItem(context),
              child: Text('Cập nhật'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'add_item_page.dart';
import 'edit_item_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() async {
    final data = await DatabaseHelper().getItems();
    setState(() {
      _items = data;
    });
  }

  void _deleteItem(int id) async {
    await DatabaseHelper().deleteItem(id);
    _refreshItems();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Xóa mục thành công!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('ADMIN'),
      backgroundColor: Colors.teal,
      centerTitle: true,
),

      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 100,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Không có dữ liệu.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      child: Text(
                        _items[index]['name'][0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.teal[100],
                    ),
                    title: Text(
                      _items[index]['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditItemPage(
                                  id: _items[index]['id'],
                                  currentName: _items[index]['name'],
                                ),
                              ),
                            ).then((value) {
                              if (value == true) {
                                _refreshItems();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Cập nhật mục thành công!'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteItem(_items[index]['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddItemPage(),
            ),
          ).then((value) {
            if (value == true) {
              _refreshItems();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Thêm mục thành công!'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            }
          });
        },
      ),
    );
  }
}


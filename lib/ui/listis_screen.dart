import 'package:flutter/material.dart';

class ListisScreen extends StatefulWidget {
  @override
  _ListisScreenState createState() => _ListisScreenState();
}

class _ListisScreenState extends State<ListisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(),

      floatingActionButton: new FloatingActionButton(
        tooltip: "Add item",
        backgroundColor: Colors.blueAccent,
        child: new ListTile(
          title: new Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
  }
}
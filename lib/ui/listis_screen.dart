import 'package:flutter/material.dart';
import 'package:listis/model/listis_item.dart';
import 'package:listis/util/db_client.dart';
import 'package:sqflite/sqlite_api.dart';

class ListisScreen extends StatefulWidget {
  @override
  _ListisScreenState createState() => _ListisScreenState();
}

class _ListisScreenState extends State<ListisScreen> {
  final _editTextController = TextEditingController();

  var db = new DatabaseHelper();

  void _handleSubmit(String text) async {
    _editTextController.clear();

    ListisItem listisItem =
        new ListisItem(text, DateTime.now().toIso8601String());
    int savedItemID = await db.saveItem(listisItem);

    print(savedItemID);
  }

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
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _editTextController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "e.g. Don't buy stuff",
                  icon: new Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmit(_editTextController.text);
              _editTextController.clear();
            },
            child: Text("Save")),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}

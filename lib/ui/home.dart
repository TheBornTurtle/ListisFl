import 'package:flutter/material.dart';
import 'package:listis/ui/listis_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Listis"),
        backgroundColor: Colors.black54,
      ),
      body: new ListisScreen(),
    );
  }
}
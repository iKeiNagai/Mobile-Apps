import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: virtualAquarium(),
    );
  }
}

class virtualAquarium extends StatefulWidget {
  @override
  _virtualAquarium createState() => _virtualAquarium();
}

class _virtualAquarium extends State<virtualAquarium> with SingleTickerProviderStateMixin {
  late AnimationController _fish_controller;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Aquarium'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(color: Colors.blueAccent)
                ),
              )
            ],
          ),
      ),
      );
}}
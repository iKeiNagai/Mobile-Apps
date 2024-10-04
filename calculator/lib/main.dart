import 'package:flutter/material.dart';
   
void main() {
  runApp(calculator());
}

class calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      home: Homepage()
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Aligns children
          children: <Widget>[
            Text(
              'Insert calculator here',
              style: TextStyle(fontSize: 24),
            ),
            // You can add more widgets here
          ],
        ),
      ),
    );
  }
}

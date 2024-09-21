import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  bool _toggleimage = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggle() {
    setState(() {
      _toggleimage = !_toggleimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Counter and Image Toggle')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pressed the button $_counter times'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment'),
              ),
              SizedBox(height: 50),
              _toggleimage
                  ? Image.network(
                      //expression if true
                      'https://th.bing.com/th/id/R.4363270904f8d09d6ae08ccf2e787069?rik=YcuEo1ubKnM%2fbA&riu=http%3a%2f%2f4.bp.blogspot.com%2f-H5MjSvN-_BU%2fVYiPgHbypLI%2fAAAAAAAAAP8%2fBK2tgk28WD8%2fs1600%2fANDROID.png&ehk=z89VsaezsLzNZPKRsUU2AbNaMb0FWaGG2wLz7UhcTEc%3d&risl=&pid=ImgRaw&r=0',
                      height: 150,
                    )
                  : Image.network(
                      //expression if false
                      'https://th.bing.com/th/id/OIP.TfmFiApYF1itohHnoJehZQHaIn?rs=1&pid=ImgDetMain',
                      height: 150,
                    ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _toggle, child: Text('Toggle Image'))
            ],
          ),
        ),
      ),
    );
  }
}

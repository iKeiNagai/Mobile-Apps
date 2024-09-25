import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _fetch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Input City Name'),
                    controller: _fetch,
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        print(_fetch);
                      });
                    },
                    child: Text('Fetch Weather')),
              ],
            ),
            SizedBox(height: 20),
            Text("City Name"),
            SizedBox(height: 20),
            Text("Temperature"),
            SizedBox(height: 20),
            Text("Weather Condition")
          ],
        ),
      ),
    );
  }
}

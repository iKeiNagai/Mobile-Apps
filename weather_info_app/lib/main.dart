import 'package:flutter/material.dart';
import 'dart:math';

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

List<String> _generated_weather(String _fetch) {
  List<String> all_info = [];
  List<String> conditions = ["Sunny", "Cloudy", "Rainy"];
  var random = Random();

  //generate number btw 15 and 30
  //temperature
  int randTemp = 15 + random.nextInt(30 - 15 + 1);
  all_info.insert(0, randTemp.toString());

  //generate index and add it to list
  //condition
  int randomIndex = random.nextInt(conditions.length);
  all_info.insert(1, conditions[randomIndex]);

  return all_info;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _fetch = TextEditingController();
  List<String> all_info = [];
  String city_name = "(Input Name)";
  String temperature = "None";
  String weather_condition = "None";

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
                        city_name = _fetch.text;
                        all_info = _generated_weather(city_name);
                        temperature = all_info[0];
                        weather_condition = all_info[1];
                      });
                    },
                    child: Text('Fetch Weather')),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "City Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("You are in $city_name"),
            SizedBox(height: 20),
            Text(
              "Temperature",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("The current temperature is $temperature"),
            SizedBox(height: 20),
            Text(
              "Weather Condition",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("Current condition is $weather_condition"),
          ],
        ),
      ),
    );
  }
}

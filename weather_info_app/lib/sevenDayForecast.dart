import 'package:flutter/material.dart';

class sevenDayForecast extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7-Days Forecast'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Monday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
            Text("Tuesday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
            Text("Wednesday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
            Text("Thursday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
            Text("Friday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
            Text("Saturday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
            Text("Sunday", 
            style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Temperature = (someValue)"),
              SizedBox(width: 20),
              Text("Condition = (someValue)")
            ]),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
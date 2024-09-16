/*
theme toggle feature with buttons for light 
and dark modes, arrows icons below theme buttons
*/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  // use this method method to change the theme
    
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
      print("Theme mode changed to: $themeMode");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.white,
          surface: Colors.deepPurple
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        ),
        brightness: Brightness.light,
      ),
    
      // standard dark theme
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
          primary: Colors.orange,
          surface: Colors.purple
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Demo ',
            style :TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose your device Theme:',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        changeTheme(ThemeMode.light);
                      },
                      child: Text('Light Mode')),
                  OutlinedButton(
                      onPressed: () {
                        changeTheme(ThemeMode.dark);
                      },
                      child: Text('Dark Mode')),
                ],
                // Create two buttons here and change the theme when the button is pressed. use children[] and create two button inside it.
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.arrow_upward, size: 50,color: Colors.green),
                  Icon(Icons.arrow_upward, size: 50,color: Colors.green,)
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
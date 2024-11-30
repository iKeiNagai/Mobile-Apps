import 'package:custom_quiz/custom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Trivia App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CustomQuiz(),
    );
  }
}

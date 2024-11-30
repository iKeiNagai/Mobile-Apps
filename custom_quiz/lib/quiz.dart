
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final int amount;       
  final String? category;  
  final String? difficulty;  
  final String? type;
  const QuizScreen({super.key,required this.amount, this.category, this.difficulty, this.type});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Screen"),
      ),
      body: Column(
        children: [
          Text('Amount of questions: ${widget.amount}'),
          Text('Category: ${widget.category ?? "N/A"}'),
          Text('Difficulty: ${widget.difficulty ?? "N/A"}'),
          Text('Type: ${widget.type ?? "N/A"}'),
        ],
      ),
    );
  }
}
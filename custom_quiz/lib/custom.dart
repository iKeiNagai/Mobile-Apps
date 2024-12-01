import 'package:custom_quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomQuiz extends StatefulWidget {
  @override
  _CustomQuizState createState() => _CustomQuizState();
}

class _CustomQuizState extends State<CustomQuiz> {
  int _numberOfQuestions = 5;
  String? _selectedCategory;
  String? _selectedDifficulty;
  String? _selectedType;
  List _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final url = Uri.parse('https://opentdb.com/api_category.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _categories = data['trivia_categories'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Number of Questions'),
            DropdownButton<int>(
              value: _numberOfQuestions,
              items: [5, 10, 15].map((number) {
                return DropdownMenuItem<int>(
                  value: number,
                  child: Text('$number'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _numberOfQuestions = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Category'),
            DropdownButton<String>(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Difficulty'),
            DropdownButton<String>(
              value: _selectedDifficulty,
              items: ['easy', 'medium', 'hard'].map((difficulty) {
                return DropdownMenuItem<String>(
                  value: difficulty,
                  child: Text(difficulty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDifficulty = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Question Type'),
            DropdownButton<String>(
              value: _selectedType,
              items: ['multiple', 'boolean'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type == 'boolean' ? 'True/False' : 'Multiple Choice'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                 MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    amount: _numberOfQuestions,
                    category: _selectedCategory,
                    difficulty: _selectedDifficulty,
                    type: _selectedType
                  )));
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
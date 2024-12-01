import 'dart:async';
import 'package:custom_quiz/API.dart';
import 'package:custom_quiz/custom.dart';
import 'package:custom_quiz/question.dart';
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
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _loading = true;
  bool _answered = false;
  String _selectedAnswer = "";
  String _feedbackText = "";
  late Timer _timer;
  int _timeremaining = 15;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await ApiService.fetchQuestions(
        widget.amount, widget.category, widget.difficulty,widget.type);
      setState(() {
        _questions = questions;
        _loading = false;
      });
      _startTimer();
    } catch (e) {
      Text("error: $e");
    }
    
  }

  void _submitAnswer(String selectedAnswer) {
    _timer.cancel();
    setState(() {
      _answered = true;
      _selectedAnswer = selectedAnswer;

      final correctAnswer = _questions[_currentQuestionIndex].correctAnswer;
      if (selectedAnswer == correctAnswer) {
        _score++;
        _feedbackText = "Correct! The answer is $correctAnswer.";
      } else {
        _feedbackText = "Incorrect. The correct answer is $correctAnswer.";
      }
    });

    Future.delayed(Duration(seconds: 2), _nextQuestion);
  }

  void _nextQuestion() {
    setState(() {
      _answered = false;
      _selectedAnswer = "";
      _feedbackText = "";
      _currentQuestionIndex++;
    });
      _startTimer();
  }

   Widget _buildOptionButton(String option) {
    return ElevatedButton(
      onPressed: _answered ? null : () => _submitAnswer(option),
      child: Text(option),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    );
  }

  void _startTimer(){
    _timeremaining = 15;
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        if(_timeremaining > 0){
          _timeremaining--;
        }else{
          _timer.cancel();
          _handleTimeout();
        }
      });
    });
  }

  void _handleTimeout() {
    setState(() {
      _feedbackText = "Time's up!";
      _answered = true;
    });
    Future.delayed(Duration(seconds: 2), _nextQuestion);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Summary'),
          centerTitle: true,
        ),
        body: Center(
          child:Column(
            children: [
              SizedBox(height: 50),
              Text('Quiz Finished! Your Score: $_score/${_questions.length}',
                    style: TextStyle(fontSize: 20),),
              OutlinedButton(
                onPressed:(){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CustomQuiz()),
                    (Route<dynamic> route) => false, //remove previous routes
                  );
                }, 
                child: Text('New Quiz'))
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${_currentQuestionIndex + 1}/${_questions.length}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Time: $_timeremaining',
            style: TextStyle(fontSize: 20),),
            Center(
              child: Text(
                'Score: $_score/${_questions.length}',
                style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 16),
            Text(
              question.question,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ...question.options.map((option) => _buildOptionButton(option)),
            SizedBox(height: 20),
            if (_answered)
              Text(
                _feedbackText,
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedAnswer == question.correctAnswer
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            if (_answered)
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text('Next Question'),
              ),
          ],
        ),
      ),
    );
  }
}
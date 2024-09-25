import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  String recipe_name = "";

  DetailScreen({required this.recipe_name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(recipe_name)
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'detailScreen.dart';

void main() {
  runApp(RecipeBook());
}

class RecipeBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<String> recipes = [
    'Spaghetti',
    'Chicken Stir-Fry',
    'Avocado Toast',
    'Vegetable Soup'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(recipe_name: recipes[index]),
                            ),
                          );
                        },
                        child: Text(recipes[index]));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

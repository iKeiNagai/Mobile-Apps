import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  String recipe_name = "";

  DetailScreen({required this.recipe_name});//receives data 

  Map<String,String> _display_details(String recipe_name) {
    String ingredients = "";
    String instructions = "";

    if (recipe_name == 'Spaghetti') {
      ingredients = '''
        - 200g spaghetti
        - 4 garlic cloves, sliced
        - 1/4 cup olive oil
        - 1/2 tsp red pepper flakes
        - Salt & pepper to taste
        ''';
      instructions = '''
        1. Cook spaghetti until al dente.
        2. In a pan, sauté garlic in olive oil until golden.
        3. Add red pepper flakes and mix.
        4. Toss in drained spaghetti, season with salt and pepper, and garnish with parsley and Parmesan.
        ''';
    }
    
    if(recipe_name == 'Chicken Stir-Fry'){
      ingredients = '''
        - 300g chicken breast, sliced
        - 1 bell pepper, sliced
        - 1 carrot, julienned
        - 2 tbsp soy sauce
        - 1 tbsp oyster sauce
        - 2 garlic cloves, minced
        - 1 tbsp vegetable oil
        - Sesame seeds for garnish
        ''';
      instructions = '''
        1. Heat oil in a pan and cook chicken until browned.
        2. Add garlic, bell pepper, and carrots, stir-frying for 5 minutes.
        3. Stir in soy sauce and oyster sauce, cooking for another 2 minutes.
        4. Garnish with sesame seeds and serve.
        ''';
    }

    if(recipe_name == 'Avocado Toast'){
      ingredients = '''
        - 2 slices of bread (toasted)
        - 1 ripe avocado
        - 1 tbsp lemon juice
        - Salt & pepper to taste
        ''';
      instructions = '''
        1. Mash the avocado and mix with lemon juice, salt, and pepper.
        2. Spread on toasted bread.
        3. Sprinkle with red pepper flakes or paprika.
        ''';
    }

    if(recipe_name == 'Egg Fried Rice'){
      ingredients = '''
        - 1 cup cooked rice
        - 2 eggs, beaten
        - 1 tbsp soy sauce
        - 1 tbsp oil
        ''';
      instructions = '''
        1. Heat oil in a pan, scramble eggs.
        2. Add rice and soy sauce, stir-fry until well combined.
        ''';
    }
    return{
      'ingredients':ingredients,
      'instructions':instructions
    };
  }


  @override
  Widget build(BuildContext context) {
    Map<String,String> info = _display_details(recipe_name);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(recipe_name),
            Text("Ingredients"),
            Text(info['ingredients'] ?? ''),
            Text(info['instructions'] ?? '')
          ],
        ),
      ),
    );
  }
}

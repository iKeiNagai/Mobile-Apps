import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matching Game',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> flipped = List.generate(8, (_) => false);
  List<String> card_elements = ['K','K','Q','Q','J','J','A','A'];
  List<int> flippedIndex = [];

  void initState(){
    super.initState();
    card_elements.shuffle();
    print(card_elements);
  }
  
  void _flip(int index,String _card){
    setState(() {
      if(flippedIndex.length < 2 && !flipped[index]){
        flipped[index] = !flipped[index];
        flippedIndex.add(index);
      }
    });
    print(_card);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Card Matching Game'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: 8,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _flip(index,card_elements[index]);
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 0),
                    child: Center(
                        child: flipped[index]
                            ? Container(
                                color: Colors.white,
                                child: Center(child: Text(card_elements[index])),
                              )
                            : Container(
                                color: Colors.purple,
                                child: Center(child: Text("Tap")),
                              )),
                  ),
                );
              }),
        ));
  }
}

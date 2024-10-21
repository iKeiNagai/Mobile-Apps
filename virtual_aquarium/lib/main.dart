import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: virtualAquarium(),
    );
  }
}

class virtualAquarium extends StatefulWidget {
  @override
  _virtualAquarium createState() => _virtualAquarium();
}

class _virtualAquarium extends State<virtualAquarium> with SingleTickerProviderStateMixin {
  late AnimationController _fish_controller;
  List<Fish> fishes = [];
  final double aquariumWidth = 300;
  final double aquariumHeight = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Aquarium'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Container(
                width: aquariumWidth,
                height: aquariumHeight,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(color: Colors.blueAccent)
                ),
                child: Stack(
                  children: fishes.map((fish) {
                  return Positioned(
                    left: aquariumHeight - 100,
                    top: aquariumWidth - 50,
                    child: fish.buildFish(),
                  );
                }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Slider(
                value: 1, 
                onChanged: (value){}
              ),
              SizedBox(height: 20),
              Text(fishes.length.toString()),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    fishes.add(Fish(color: Colors.black));
                  });
                }, 
                child: Text('Add new fish')
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                },
                child: Text('Save Settings'))
            ],
          ),
      ),
      );
}}

class Fish{
  final Color color;

  Fish({required this.color});

  Widget buildFish(){
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
    );
  }

}
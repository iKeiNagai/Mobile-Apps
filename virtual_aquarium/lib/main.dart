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
  void initState(){
    super.initState();
    _fish_controller = AnimationController(
      duration:  const Duration(seconds: 2),
      vsync: this
      )..addListener((){
        setState(() {
          for(var fish in fishes){
            fish.move(aquariumWidth, aquariumHeight);
          }
        });
      })..repeat();

  }

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
                    left: fish.position.dx,
                    top: fish.position.dy,
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
                    fishes.add(Fish(color: Colors.black, aquariumWidth: aquariumWidth, aquariumHeight: aquariumHeight));
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
  Offset position;
  Offset velocity;

  Fish({required this.color, required double aquariumWidth, required double aquariumHeight})
      : position = Offset(Random().nextDouble() * (aquariumWidth - 50), Random().nextDouble() * (aquariumHeight - 50)),
        velocity = Offset((Random().nextBool() ? 1 : -1) * (1 + Random().nextDouble() * 2), (Random().nextBool() ? 1 : -1) * (1 + Random().nextDouble() * 2));

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

  void move(double aquariumWidth, double aquariumHeight){
    position += velocity;

    if (position.dx < 0 || position.dx > aquariumWidth - 50) {
      velocity = Offset(-velocity.dx, velocity.dy); 
    }
    if (position.dy < 0 || position.dy > aquariumHeight - 50) {
      velocity = Offset(velocity.dx, -velocity.dy); 
    }
  }

}
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
  double speed = 1.0;
  Color? selected;


  @override
  void initState(){
    super.initState();
    _fish_controller = AnimationController(
      duration:  const Duration(seconds: 2),
      vsync: this
      )..addListener((){
        setState(() {
          for(var fish in fishes){
            fish.move(aquariumWidth, aquariumHeight, speed);
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
              Text("Adjust Speed"),
              Slider(
                value: speed,
                min: 0,
                max: 2.0,
                divisions: 20,
                onChanged: (value){
                  setState(() {
                    speed = value;
                  });
                }
              ),
              SizedBox(height: 20),
              Text(fishes.length.toString()),
              Text("Select fish color"),
              DropdownButton<Color>(
                value: selected,
                items: Colors.primaries.map((Color color){
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        height: 50,
                        color: color,
                      ),
                    ));
                }).toList(),
                onChanged: (Color? newValue){
                  selected = newValue!;
                },
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    if(selected != null){
                    fishes.add(Fish(color: selected, aquariumWidth: aquariumWidth, aquariumHeight: aquariumHeight));
                    }
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
  final Color? color;
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

  void move(double aquariumWidth, double aquariumHeight, double speed){
    position += velocity * speed;

    if (position.dx < 0 || position.dx > aquariumWidth - 50) {
      velocity = Offset(-velocity.dx, velocity.dy); 
    }
    if (position.dy < 0 || position.dy > aquariumHeight - 50) {
      velocity = Offset(velocity.dx, -velocity.dy); 
    }
  }

}
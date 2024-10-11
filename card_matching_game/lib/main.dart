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
                      flipped[index] = !flipped[index];
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    child: Center(
                        child: flipped[index]
                            ? Container(
                                color: Colors.white,
                                child: Center(child: Text("Back")),
                              )
                            : Container(
                                color: Colors.purple,
                                child: Center(child: Text("Front")),
                              )),
                  ),
                );
              }),
        ));
  }
}

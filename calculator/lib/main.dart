import 'package:flutter/material.dart';

void main() {
  runApp(calculator());
}

class calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Simple Calculator', home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Aligns children
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 56,
                  width: 224,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Text("value here"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("1"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("2"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("3"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("+"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("4"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("5"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("6"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("-"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("7"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("8"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("9"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("/"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Container(
                  height: 56.0,
                  width: 112.0,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Text("Clear"),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("0"),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Text("*"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

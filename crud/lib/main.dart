import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List of Tasks',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _insert = TextEditingController();

  List<String> ltasks = ["1 task", "2 task"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                  padding: EdgeInsets.all(25),
                  child: TextField(
                    decoration: InputDecoration(labelText: "Enter task name"),
                    controller: _insert,
                  ),
                )
                ),
                FloatingActionButton(onPressed: () {
                  setState(() {
                    ltasks.add(_insert.text);
                  });
                }, child: Text("Add"))
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: ltasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            Text(ltasks[index]),
                            SizedBox(width: 30),
                            Checkbox(value: false, onChanged: null),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    ltasks.removeAt(index);
                                  });
                                }, child: Text("remove"))
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

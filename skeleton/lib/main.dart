import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget that will be started on the application startup
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
//initial couter value
final TextEditingController _controller1=TextEditingController();
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              child: Text(
                //displays the current number
                '$_counter',
                style: TextStyle(fontSize: _counter.toDouble()),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed:(){
                  setState(() {
                    if(_counter > 0){
                      _counter--;
                    }
                  });
                }, 
              child: Text('Decrement'),
              ),
              OutlinedButton(
                onPressed:(){
                  setState(() {
                    _counter = 0;
                  });
                }, 
                child: Text('Reset'),
                ),
            ],
          ),
          Container(
            width: 150,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Increment by:',
              ),
            controller: _controller1,
            ),
          ),
          ElevatedButton(
            onPressed:(){
              setState(() {
                int? _userValue = int.tryParse(_controller1.text);

                if(_userValue != null && _counter < 100){
                  _counter += _userValue;
                }
              });
            }, 
            child: Text('enter'),
          ),
        ],
      ),
    );
  }
}

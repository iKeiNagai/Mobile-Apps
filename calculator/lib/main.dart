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
  String displayText = '';
  int? firstNum;
  int? secondNum;
  String operator = "";


  void _displayText(String value){
    setState(() {
      displayText += value;
    });
  }

  void _operator(String op){
    firstNum = int.tryParse(displayText);
    operator = op;
    displayText = '';
    print(operator);
  }

  void calculate(){
    setState(() {
      secondNum = int.tryParse(displayText);
      if(firstNum != null && secondNum!= null && operator!= null){
        switch(operator){
          case '+':
            displayText = (firstNum! + secondNum!).toString();
            break;
          case '-':
            displayText = (firstNum! - secondNum!).toString();
            break;
          case '*':
            displayText = (firstNum! * secondNum!).toString();
            break;
          case '/':
            if(secondNum != 0){
              displayText = (firstNum! / secondNum!).toString();
            }
            displayText = "cant divide by zero";
            break;
        }
      }
    });
  }

  void clear_button(){
    setState(() {
      displayText ='';
      firstNum = null;
      secondNum = null;
      operator = '';
    });
  }


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
                  child: Text(displayText),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _displayText('1');
                  },
                  child: Text("1"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('2');
                  },
                  child: Text("2"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('3');
                  },
                  child: Text("3"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _operator("+");
                  },
                  child: Text("+"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _displayText('4');
                  },
                  child: Text("4"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('5');
                  },
                  child: Text("5"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('6');
                  },
                  child: Text("6"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _operator("-");
                  },
                  child: Text("-"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _displayText('7');
                  },
                  child: Text("7"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('8');
                  },
                  child: Text("8"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('9');
                  },
                  child: Text("9"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _operator("/");
                  },
                  child: Text("/"),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                FloatingActionButton(
                    onPressed: () {
                      clear_button();
                    },
                    child: Text("Clear"),
                  ),
                FloatingActionButton(
                  onPressed: () {
                    _displayText('0');
                  },
                  child: Text("0"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _operator('*');
                  },
                  child: Text("*"),
                ),
              FloatingActionButton(
                    onPressed: () {
                      calculate();
                    },
                    child: Text("="),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

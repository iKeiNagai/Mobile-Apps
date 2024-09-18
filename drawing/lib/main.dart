import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrawingApp(),
    );
  }
}

class DrawingApp extends StatefulWidget {
  @override
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  List<List<Offset>> lines = []; // Use a list of lists for each line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing App'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            final localPosition =
                renderBox.globalToLocal(details.globalPosition);
            if (lines.isEmpty || lines.last.isEmpty) {
              lines.add([localPosition]);
            } else {
              lines.last.add(localPosition);
            }
          });
        },
        onPanEnd: (_) {
          setState(() {
            lines.add([]);
          });
        },
        child: CustomPaint(
          painter: MyPainter(lines),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            lines.clear();
          });
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<List<Offset>> lines;
  MyPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    final ovalColor = Paint()
      ..color = Colors.black;

    canvas.drawCircle(Offset(size.width/2,size.height/2),150, paint);
    canvas.drawCircle(Offset(size.width/2-50,size.height/2-50), 30, ovalColor);
    canvas.drawCircle(Offset(size.width/2+50,size.height/2-50), 30, ovalColor);

    final smileRect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2 + 20), radius: 80);
    canvas.drawArc(smileRect, pi/8, pi-pi /4, false, ovalColor);

    for (final line in lines) {
      for (int i = 0; i < line.length - 1; i++) {
        canvas.drawLine(line[i], line[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

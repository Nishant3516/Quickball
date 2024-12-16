import 'package:flutter/material.dart';
import 'package:quick_ball/features/scribble/presentation/widgets/scribble_painter.dart';

class ScribblerApp extends StatefulWidget {
  const ScribblerApp({super.key});

  @override
  _ScribblerAppState createState() => _ScribblerAppState();
}

class _ScribblerAppState extends State<ScribblerApp> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scribbler'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                points.clear();
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          setState(() {
            points.add(renderBox.globalToLocal(details.globalPosition));
          });
        },
        onPanEnd: (details) {
          points.add(null); // Add a null point to indicate the end of a stroke
        },
        child: CustomPaint(
          painter: ScribblePainter(points),
          child: Container(),
        ),
      ),
    );
  }
}

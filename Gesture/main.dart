import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gesture Demo',
      home: GestureDemoScreen(),
    );
  }
}

class GestureDemoScreen extends StatelessWidget {
  const GestureDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Demo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _showSnackbar(context, 'Single Tap');
              },
              onDoubleTap: () {
                _showSnackbar(context, 'Double Tap');
              },
              onLongPress: () {
                _showSnackbar(context, 'Long Press');
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 115, 209, 247),
                  borderRadius: BorderRadius.circular(75),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), 
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Tap Me',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const PinchZoomContainer(),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class PinchZoomContainer extends StatefulWidget {
  const PinchZoomContainer({super.key});

  @override
  _PinchZoomContainerState createState() => _PinchZoomContainerState();
}

class _PinchZoomContainerState extends State<PinchZoomContainer> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = _previousScale * details.scale;
        });
      },
      onScaleEnd: (ScaleEndDetails details) {
        setState(() {
          _previousScale = _scale;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 40, 23),
            shape: BoxShape.circle, // Circular shape
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color
                spreadRadius: 3,
                blurRadius: 6,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Zoom In or Out',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

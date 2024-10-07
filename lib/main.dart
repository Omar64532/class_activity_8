import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpookyCharacterAnimation(),
    );
  }
}

class SpookyCharacterAnimation extends StatefulWidget {
  const SpookyCharacterAnimation({super.key});

  @override
  _SpookyCharacterAnimationState createState() =>
      _SpookyCharacterAnimationState();
}

class _SpookyCharacterAnimationState extends State<SpookyCharacterAnimation> {
  // Initial positions for the ghost and bat
  double _ghostYPosition = 0;
  double _ghostXPosition = 0;
  double _batXPosition = -150;
  double _rotationAngle = 0;

  bool _isPumpkinVisible = false; // Initially hidden Pumpkinhead


  void moveCharacters() {
    setState(() {
      _ghostYPosition = _ghostYPosition == 0 ? -100 : 0; 
      _ghostXPosition = _ghostXPosition == 0 ? 150 : 0; 

      _batXPosition = _batXPosition == -150 ? 150 : -150; 

      _rotationAngle += 3.14 / 2; 
      _isPumpkinVisible = !_isPumpkinVisible; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spooky Halloween Animation'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ghost - Moves up/down, left/right, and rotates on tap
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              top: _ghostYPosition,
              left: _ghostXPosition,
              child: GestureDetector(
                onTap: moveCharacters, 
                child: AnimatedRotation(
                  turns: _rotationAngle / (2 * 3.14),
                  duration: const Duration(seconds: 2),
                  child: Image.asset(
                    'assets/images/ghost.png', 
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Bat - Moves horizontally across the screen
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              left: _batXPosition,
              top: 50, 
              child: GestureDetector(
                onTap: moveCharacters, 
                child: Image.asset(
                  'assets/images/bat.png', // Replace with your bat image
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Pumpkinhead - Visible when tapped
            if (_isPumpkinVisible)
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: _isPumpkinVisible ? 1.0 : 0.0,
                child: Image.asset(
                  'assets/images/Pumpkinhead.png', 
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveCharacters,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

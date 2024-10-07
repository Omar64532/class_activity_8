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
  _SpookyCharacterAnimationState createState() => _SpookyCharacterAnimationState();
}

class _SpookyCharacterAnimationState extends State<SpookyCharacterAnimation> {
  bool _isVisible = true;
  double _rotationAngle = 0;

  // Toggle visibility of a spooky character
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Rotate the spooky character
  void rotateGhost() {
    setState(() {
      _rotationAngle += 3.14 * 2; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Spooky Characters'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: toggleVisibility,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut, 
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/ghost.png', 
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: rotateGhost,
              child: AnimatedRotation(
                turns: _rotationAngle / (2 * 3.14), 
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/images/bat.png', 
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  const FadingTextAnimation({super.key});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  double _rotationAngle = 0;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void rotateDaGhost() {
    setState(() {
      _rotationAngle += 3.14 * 2; // 360 degrees rotation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fading Text Animation // Click the Ghost!!!'),
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
                curve: Curves.easeInOut, // Apply curve for smooth transition
                child: Column(
                  children: [
                    const Text(
                      'Hello, Flutter!',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/Pumpkinhead.png',
                      width: 100,
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: rotateDaGhost, // Trigger rotation on tap
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        child: AnimatedRotation(
                          turns: _rotationAngle /
                              (2 * 3.14), // Full rotation (360 degrees)
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
                  ],
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

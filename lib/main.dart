/// Naved Noor, Hashim-Omar Omar

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WinningElementScreen(),
    );
  }
}

class WinningElementScreen extends StatefulWidget {
  const WinningElementScreen({super.key});

  @override
<<<<<<< HEAD
  _WinningElementScreenState createState() => _WinningElementScreenState();
=======
  _SpookyCharacterAnimationState createState() =>
      _SpookyCharacterAnimationState();
>>>>>>> 0c7a14d955b051ad77c2314061dc613002b666bd
}

class _WinningElementScreenState extends State<WinningElementScreen> {
  double _treasureXPosition = 0;
  double _treasureYPosition = 0;
  bool _isTreasureFound = false;

  // Function to hide and move the treasure around randomly
  void moveTreasure() {
    setState(() {
      _treasureXPosition = (100 + (100 * (0.5 - (0.5))));
      _treasureYPosition = (100 + (100 * (0.5 - (0.5))));
    });
  }

  // Function to detect if the correct item (treasure) is clicked
  void treasureFound() {
    setState(() {
<<<<<<< HEAD
      _isTreasureFound = true; 
=======
      _rotationAngle += 3.14 * 2;
>>>>>>> 0c7a14d955b051ad77c2314061dc613002b666bd
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find the Treasure!'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
<<<<<<< HEAD
            // Moving the treasure (correct item)
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              top: _treasureYPosition,
              left: _treasureXPosition,
              child: GestureDetector(
                onTap: treasureFound, 
                child: Image.asset(
                  'assets/images/treasure.png', 
=======
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
>>>>>>> 0c7a14d955b051ad77c2314061dc613002b666bd
                  width: 100,
                  height: 100,
                ),
              ),
            ),

            // Display message when treasure is found
            if (_isTreasureFound)
              const Positioned(
                bottom: 50,
                child: Text(
                  'You Found It!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveTreasure, // Move the treasure to a new random location
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

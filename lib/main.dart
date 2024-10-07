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
  _WinningElementScreenState createState() => _WinningElementScreenState();
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
      _isTreasureFound = true; 
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
            // Moving the treasure (correct item)
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              top: _treasureYPosition,
              left: _treasureXPosition,
              child: GestureDetector(
                onTap: treasureFound, 
                child: Image.asset(
                  'assets/images/treasure.png', 
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

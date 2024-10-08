import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

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
  double _broomXPosition = 0;
  bool _isTreasureFound = false;
  late AudioPlayer _audioPlayer;
  bool _isJumpScareTriggered = false;

  // New fields to manage ghost, pumpkin, and bat positions
  bool _isVisible = true;
  double _rotationAngle = 0;

  // Random positions for Halloween characters
  double _ghostXPosition = 0;
  double _ghostYPosition = 0;
  double _pumpkinXPosition = 0;
  double _pumpkinYPosition = 0;
  double _batXPosition = 0;
  double _batYPosition = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    _startMovingHalloweenCharacters(); // Start moving characters
  }

  // Function to play background music in a loop
  void _playBackgroundMusic() async {
    await _audioPlayer.setSource(AssetSource('audio/Hallowed_Ground.wav'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set to loop
    await _audioPlayer.resume(); // Start playing
  }

  // Function to hide and move the treasure around randomly
  void moveTreasure() {
    setState(() {
      _isTreasureFound = false; // Reset the treasure found status
      _treasureXPosition =
          Random().nextDouble() * 200 - 100; // Randomize X position
    });
  }

  // Function to detect if the treasure is found
  void treasureFound() {
    setState(() {
      _isTreasureFound = true;
    });
    _playVictoryAudio();
  }

  // Play victory sound when treasure is found
  void _playVictoryAudio() async {
    await _audioPlayer.play(AssetSource('audio/victory.mp3'));
  }

  // Trigger jump scare when pumpkin is clicked
  void pumpkinClicked() async {
    setState(() {
      _isJumpScareTriggered = true;
    });
    await _audioPlayer.play(AssetSource('audio/jumpscare1.mp3'));
  }

  // Move broom to the left when clicked
  void moveBroom() {
    setState(() {
      _broomXPosition -= 50; // Move left
    });
  }

  // Toggle ghost visibility
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Rotate the bat and play sound
  void rotateBat() async {
    setState(() {
      _rotationAngle += 3.14 * 2; // Increment angle for rotation
    });
    await _audioPlayer
        .play(AssetSource('audio/batsound.mp3')); // Play bat sound
  }

  // Start moving Halloween characters randomly
  void _startMovingHalloweenCharacters() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      // Increase timer duration for slower movement
      setState(() {
        // Generate new positions while ensuring they stay within the screen bounds
        _ghostXPosition = Random().nextDouble() *
            (MediaQuery.of(context).size.width -
                100); // 100 for the width of the ghost image
        _ghostYPosition = Random().nextDouble() *
            (MediaQuery.of(context).size.height -
                200); // 200 for the height of the ghost image + some margin

        _pumpkinXPosition =
            Random().nextDouble() * (MediaQuery.of(context).size.width - 100);
        _pumpkinYPosition =
            Random().nextDouble() * (MediaQuery.of(context).size.height - 200);

        _batXPosition =
            Random().nextDouble() * (MediaQuery.of(context).size.width - 100);
        _batYPosition =
            Random().nextDouble() * (MediaQuery.of(context).size.height - 200);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple, // Set background color to purple
      appBar: AppBar(
        title: const Text('Find the Treasure!'),
      ),
      body: Stack(
        children: [
          // Moving ghost
          AnimatedPositioned(
            left: _ghostXPosition,
            top: _ghostYPosition,
            duration: const Duration(seconds: 2), // Match the timer duration
            child: GestureDetector(
              onTap: toggleVisibility, // Hide ghost when clicked
              child: Visibility(
                visible: _isVisible, // Control visibility
                child: Image.asset(
                  'assets/images/ghost.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          // Moving pumpkin
          AnimatedPositioned(
            left: _pumpkinXPosition,
            top: _pumpkinYPosition,
            duration: const Duration(seconds: 2), // Match the timer duration
            child: GestureDetector(
              onTap: pumpkinClicked, // Trigger jump scare
              child: Image.asset(
                'assets/images/Pumpkinhead.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          // Moving bat
          AnimatedPositioned(
            left: _batXPosition,
            top: _batYPosition,
            duration: const Duration(seconds: 2), // Match the timer duration
            child: GestureDetector(
              onTap: rotateBat, // Rotate bat when clicked
              child: Transform.rotate(
                angle: _rotationAngle, // Rotate bat based on angle
                child: Image.asset(
                  'assets/images/bat.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          // Center elements (broom and treasure)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Row with broom and treasure images
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(
                          _broomXPosition, 0), // Move broom based on position
                      child: GestureDetector(
                        onTap: moveBroom, // Move broom when clicked
                        child: Image.asset(
                          'assets/images/broom.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    GestureDetector(
                      onTap: treasureFound, // Detect if treasure is tapped
                      child: Image.asset(
                        'assets/images/treasure.png', // The treasure image
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),

                // Display jump scare if triggered
                if (_isJumpScareTriggered)
                  Image.asset(
                    'assets/images/jumpscare1.png',
                    width: 200,
                    height: 200,
                  ),

                // Display "You Found It!" message when treasure is found
                if (_isTreasureFound)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveTreasure, // Move the treasure to a new random location
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

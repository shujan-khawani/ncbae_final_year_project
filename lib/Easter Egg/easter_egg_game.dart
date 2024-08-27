// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class GuessTheWordGame extends StatefulWidget {
  const GuessTheWordGame({super.key});

  @override
  _GuessTheWordGameState createState() => _GuessTheWordGameState();
}

class _GuessTheWordGameState extends State<GuessTheWordGame> {
  final List<String> _words = [
    'hello',
    'coffee',
    'dinosaur',
    'watermelon',
    'nostalgia'
  ];
  int _currentIndex = 0;
  int _score = 0;
  final TextEditingController _controller = TextEditingController();

  String _getObscuredWord() {
    final word = _words[_currentIndex];
    if (word.length <= 2) return word; // Return word as is if too short
    return '${word[0]}${' _ ' * (word.length - 2)}${word[word.length - 1]}';
  }

  void _checkGuess() {
    if (_controller.text.toLowerCase() == _words[_currentIndex]) {
      setState(() {
        _score++;
        _currentIndex++;
        _controller.clear();
        if (_currentIndex >= _words.length) {
          _showEndDialog();
          // Reset game state after showing dialog
          _currentIndex = 0;
          _score = 0;
        }
      });
    }
  }

  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Happy Easter! You Won!\nNow Buy Me a Coffee!'),
          content: const Text('Your score: 5/5'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentIndex = 0;
                  _score = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Easter Zone'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Guess the word:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              _currentIndex < _words.length ? _getObscuredWord() : 'Game Over',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your guess',
              ),
              onSubmitted: (value) => _checkGuess(),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

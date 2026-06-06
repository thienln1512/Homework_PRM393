import 'dart:math';

import 'package:flutter/material.dart';

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  final Random _random = Random();
  Color _backgroundColor = Colors.white;
  String _colorName = 'White';

  void _setColor(Color color, String name) {
    setState(() {
      _backgroundColor = color;
      _colorName = name;
    });
  }

  void _setRandomColor() {
    final color = Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );

    _setColor(color, 'Random (${color.r}, ${color.g}, ${color.b})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Background Color Changer')),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: _backgroundColor,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Current color: $_colorName',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: () => _setColor(Colors.red, 'Red'),
                      child: const Text('Red'),
                    ),
                    FilledButton(
                      onPressed: () => _setColor(Colors.green, 'Green'),
                      child: const Text('Green'),
                    ),
                    FilledButton(
                      onPressed: () => _setColor(Colors.blue, 'Blue'),
                      child: const Text('Blue'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _setRandomColor,
                      icon: const Icon(Icons.casino),
                      label: const Text('Random'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

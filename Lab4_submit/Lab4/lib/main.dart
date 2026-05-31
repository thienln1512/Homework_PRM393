import 'package:flutter/material.dart';

import 'ex1.dart';
import 'ex2.dart';
import 'ex3.dart';
import 'ex4.dart';
import 'ex5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab4 Exercises',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const ExerciseHomePage(),
    );
  }
}

class ExerciseHomePage extends StatelessWidget {
  const ExerciseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 Exercises')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, 'Exercise 1', const Exercise1Screen()),
          _buildNavItem(context, 'Exercise 2', const Exercise2Screen()),
          _buildNavItem(context, 'Exercise 3', const Exercise3Screen()),
          _buildNavItem(context, 'Exercise 4', const Exercise4Screen()),
          _buildNavItem(context, 'Exercise 5', const Exercise5Screen()),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, Widget screen) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';

class Exercise2Screen extends StatelessWidget {
  const Exercise2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text('Item ${index + 1}', style: const TextStyle(fontSize: 16)),
          );
        },
      ),
    );
  }
}


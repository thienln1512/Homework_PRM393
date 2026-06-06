import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _count = 0;

  void _changeCount(int value) {
    setState(() {
      _count += value;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final countColor = _count > 10 ? Colors.red : Colors.teal;

    return Scaffold(
      appBar: AppBar(title: const Text('Enhanced Counter App')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Current number'),
            const SizedBox(height: 8),
            Text(
              '$_count',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: countColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _changeCount(1),
                  icon: const Icon(Icons.add),
                  label: const Text('+'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _changeCount(-1),
                  icon: const Icon(Icons.remove),
                  label: const Text('-'),
                ),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

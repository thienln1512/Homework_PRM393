import 'package:flutter/material.dart';

class Exercise3Screen extends StatelessWidget {
  const Exercise3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const _SimpleItem('LidTerm', 3),
      const _SimpleItem('CraftRock', 4),
      const _SimpleItem('BootClay', 5),
      const _SimpleItem('CheckSuit', 6),
      const _SimpleItem('TeamSake', 7),
      const _SimpleItem('NewLaugh', 8),
      const _SimpleItem('BlueCop', 9),
      const _SimpleItem('WildTent', 10),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Getting Started Testing'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.count.toString()),
              trailing: const Icon(Icons.favorite_border),
            ),
          );
        },
      ),
    );
  }
}

class _SimpleItem {
  final String title;
  final int count;

  const _SimpleItem(this.title, this.count);
}


import 'package:flutter/material.dart';

class Exercise4Screen extends StatelessWidget {
  const Exercise4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      _Group('Team A', [
        const _Member('KL', 'Klay Lewis', Colors.pink),
        const _Member('EW', 'Ehsan Woodard', Colors.purple),
        const _Member('RB', 'River Bains', Colors.blueGrey),
      ]),
      _Group('Team B', [
        const _Member('TD', 'Toyah Downs', Colors.redAccent),
        const _Member('TK', 'Tyla Kane', Colors.teal),
      ]),
      _Group('Team C', [
        const _Member('MR', 'Marcus Romero', Colors.orange),
        const _Member('FP', 'Farrah Parkes', Colors.deepPurple),
      ]),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Group List View Demo')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: groups.length,
        itemBuilder: (context, groupIndex) {
          final group = groups[groupIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  group.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (final member in group.members)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: member.color,
                      child: Text(member.initials, style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(member.name),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Group {
  final String title;
  final List<_Member> members;

  const _Group(this.title, this.members);
}

class _Member {
  final String initials;
  final String name;
  final Color color;

  const _Member(this.initials, this.name, this.color);
}


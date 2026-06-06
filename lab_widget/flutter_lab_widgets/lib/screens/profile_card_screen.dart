import 'package:flutter/material.dart';

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Profile Card')),
      body: Center(
        child: Container(
          width: 340,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 54,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              const SizedBox(height: 16),
              Text(
                'Lê Ngọc Thiện',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.code, size: 18, color: Colors.teal),
                  SizedBox(width: 6),
                  Text('Software Engineering'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'I enjoy building clean mobile interfaces and learning how widgets work together in Flutter.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.email),
                label: const Text('Contact'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF2F7F6),
    );
  }
}

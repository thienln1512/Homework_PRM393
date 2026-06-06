import 'package:flutter/material.dart';

class BusinessCardScreen extends StatelessWidget {
  const BusinessCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Card App')),
      body: Center(
        child: Container(
          width: 360,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF12343B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FptLogo(),
              SizedBox(height: 18),
              Text(
                'Lê Ngọc Thiện',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Fresher',
                style: TextStyle(color: Color(0xFFB8E1DD), fontSize: 16),
              ),
              Divider(height: 32, color: Colors.white24),
              _BusinessInfoRow(icon: Icons.phone, text: '0905180784'),
              SizedBox(height: 12),
              _BusinessInfoRow(icon: Icons.email, text: 'GGlk8thien@gmail.com'),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE7F3F1),
    );
  }
}

class _FptLogo extends StatelessWidget {
  const _FptLogo();

  @override
  Widget build(BuildContext context) {
    const letters = [
      _LogoPart('F', Color(0xFF0B8F43)),
      _LogoPart('P', Color(0xFFF37021)),
      _LogoPart('T', Color(0xFF1A73B7)),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: letters
          .map(
            (part) => Container(
              width: 58,
              height: 58,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: part.color,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                part.letter,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _LogoPart {
  const _LogoPart(this.letter, this.color);

  final String letter;
  final Color color;
}

class _BusinessInfoRow extends StatelessWidget {
  const _BusinessInfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String name;
  final String price;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 92, color: color),
            ),
            const SizedBox(height: 18),
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.teal,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}

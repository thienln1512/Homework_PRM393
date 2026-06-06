import 'package:flutter/material.dart';
import '../widgets/product_card.dart';

class ProductDisplayScreen extends StatelessWidget {
  const ProductDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _ProductAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: ProductCard(
            name: 'Flutter Backpack',
            price: r'$29.99',
            description:
                'A lightweight backpack for students who carry books, laptop, and daily study tools.',
            icon: Icons.backpack,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}

class _ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProductAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('Product Display Screen'));
  }
}

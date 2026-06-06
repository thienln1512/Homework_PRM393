import 'package:flutter/material.dart';

class CoffeeOrderScreen extends StatefulWidget {
  const CoffeeOrderScreen({super.key});

  @override
  State<CoffeeOrderScreen> createState() => _CoffeeOrderScreenState();
}

class _CoffeeOrderScreenState extends State<CoffeeOrderScreen> {
  final List<_MenuItem> _items = const [
    _MenuItem(name: 'Coffee', price: 2, icon: Icons.coffee),
    _MenuItem(name: 'Milk Tea', price: 3.5, icon: Icons.local_drink),
    _MenuItem(name: 'Cake', price: 2.5, icon: Icons.cake),
  ];

  final Map<String, int> _quantities = {'Coffee': 0, 'Milk Tea': 0, 'Cake': 0};

  double get _total {
    return _items.fold(0, (sum, item) {
      return sum + item.price * (_quantities[item.name] ?? 0);
    });
  }

  void _updateQuantity(String name, int change) {
    setState(() {
      final current = _quantities[name] ?? 0;
      _quantities[name] = (current + change).clamp(0, 99);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coffee Shop Ordering App')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
                final quantity = _quantities[item.name] ?? 0;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(child: Icon(item.icon)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text('\$${item.price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => _updateQuantity(item.name, -1),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '$quantity',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _updateQuantity(item.name, 1),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              'Total: \$${_total.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.name,
    required this.price,
    required this.icon,
  });

  final String name;
  final double price;
  final IconData icon;
}

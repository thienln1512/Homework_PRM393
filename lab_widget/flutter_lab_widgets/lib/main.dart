import 'package:flutter/material.dart';
import 'screens/business_card_screen.dart';
import 'screens/coffee_order_screen.dart';
import 'screens/color_changer_screen.dart';
import 'screens/counter_screen.dart';
import 'screens/product_display_screen.dart';
import 'screens/profile_card_screen.dart';
import 'screens/student_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Lab Widgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LabHomeScreen(),
    );
  }
}

class LabHomeScreen extends StatelessWidget {
  const LabHomeScreen({super.key});

  static final List<_LabItem> _labs = [
    _LabItem(
      title: 'Personal Profile Card',
      subtitle: 'StatelessWidget',
      icon: Icons.account_circle,
      screen: const ProfileCardScreen(),
    ),
    _LabItem(
      title: 'Business Card App',
      subtitle: 'StatelessWidget',
      icon: Icons.business_center,
      screen: const BusinessCardScreen(),
    ),
    _LabItem(
      title: 'Product Display Screen',
      subtitle: 'StatelessWidget + reusable widget',
      icon: Icons.shopping_bag,
      screen: const ProductDisplayScreen(),
    ),
    _LabItem(
      title: 'Enhanced Counter App',
      subtitle: 'StatefulWidget',
      icon: Icons.exposure_plus_1,
      screen: const CounterScreen(),
    ),
    _LabItem(
      title: 'Background Color Changer',
      subtitle: 'StatefulWidget',
      icon: Icons.palette,
      screen: const ColorChangerScreen(),
    ),
    _LabItem(
      title: 'Student Information Form',
      subtitle: 'StatefulWidget + TextField',
      icon: Icons.school,
      screen: const StudentFormScreen(),
    ),
    _LabItem(
      title: 'Coffee Shop Ordering App',
      subtitle: 'StatefulWidget + realtime total',
      icon: Icons.local_cafe,
      screen: const CoffeeOrderScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Lab Widgets')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _labs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final lab = _labs[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(lab.icon)),
              title: Text(lab.title),
              subtitle: Text(lab.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute<void>(builder: (_) => lab.screen));
              },
            ),
          );
        },
      ),
    );
  }
}

class _LabItem {
  const _LabItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.screen,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget screen;
}

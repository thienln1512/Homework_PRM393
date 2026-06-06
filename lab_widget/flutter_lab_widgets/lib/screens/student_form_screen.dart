import 'package:flutter/material.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  String? _fullName;
  String? _studentId;
  String? _className;

  void _showInformation() {
    setState(() {
      _fullName = _nameController.text.trim();
      _studentId = _studentIdController.text.trim();
      _className = _classController.text.trim();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasInformation =
        (_fullName?.isNotEmpty ?? false) ||
        (_studentId?.isNotEmpty ?? false) ||
        (_className?.isNotEmpty ?? false);

    return Scaffold(
      appBar: AppBar(title: const Text('Student Information Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _classController,
              decoration: const InputDecoration(
                labelText: 'Class',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.group),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _showInformation,
              icon: const Icon(Icons.visibility),
              label: const Text('Show Information'),
            ),
            const SizedBox(height: 24),
            if (hasInformation)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entered Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Full Name: ${_fullName!.isEmpty ? '-' : _fullName}',
                      ),
                      Text(
                        'Student ID: ${_studentId!.isEmpty ? '-' : _studentId}',
                      ),
                      Text('Class: ${_className!.isEmpty ? '-' : _className}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

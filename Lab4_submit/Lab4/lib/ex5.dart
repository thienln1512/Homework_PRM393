import 'package:flutter/material.dart';

class Exercise5Screen extends StatefulWidget {
  const Exercise5Screen({super.key});

  @override
  State<Exercise5Screen> createState() => _Exercise5ScreenState();
}

class _Exercise5ScreenState extends State<Exercise5Screen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _remember = false;
  bool _obscure = true;
  bool _submitted = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    String? emailError;
    if (email.isEmpty) {
      emailError = 'Email is required.';
    } else if (!emailRegex.hasMatch(email)) {
      emailError = 'Invalid email format.';
    }

    String? passwordError;
    if (password.isEmpty) {
      passwordError = 'Password is required.';
    } else if (password.length < 8) {
      passwordError = 'Password must be at least 8 characters long.';
    }

    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
    });
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });
    _validate();
    if (_emailError == null && _passwordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login submitted.')),
      );
    }
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _submitted = false;
      _emailError = null;
      _passwordError = null;
      _remember = false;
      _obscure = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Icon(Icons.lock, size: 64, color: Colors.blueGrey),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: _submitted ? _emailError : null,
                isDense: true,
              ),
              onChanged: (_) {
                if (_submitted) {
                  _validate();
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: _obscure,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: _submitted ? _passwordError : null,
                isDense: true,
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                ),
              ),
              onChanged: (_) {
                if (_submitted) {
                  _validate();
                }
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _remember,
                  onChanged: (value) {
                    setState(() {
                      _remember = value ?? false;
                    });
                  },
                ),
                const Text('Remember password'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearForm,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}


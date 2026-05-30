import 'package:flutter/material.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Student',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin Sinh viên'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Lê Ngọc Thiện',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'MSSV: DE180547',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(thickness: 1.5),
                const SizedBox(height: 15),

                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: const ListTile(
                    leading: Icon(Icons.class_, color: Colors.blueAccent),
                    title: Text('Lớp học'),
                    subtitle: Text('SE18D07'),
                  ),
                ),

                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: const ListTile(
                    leading: Icon(Icons.email, color: Colors.blueAccent),
                    title: Text('Email'),
                    subtitle: Text('thienlnde180547@fpt.edu.vn'),
                  ),
                ),

                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: const ListTile(
                    leading: Icon(Icons.phone, color: Colors.blueAccent),
                    title: Text('Số điện thoại'),
                    subtitle: Text('0905180784'),
                  ),
                ),

                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blueAccent),
                    title: Text('Quê quán'),
                    subtitle: Text('Đà Nẵng, Việt Nam'),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
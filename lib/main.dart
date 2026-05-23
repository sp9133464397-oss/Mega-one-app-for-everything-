import 'package:flutter/material.dart';

void main() {
  runApp(const MegaApp());
}

class MegaApp extends StatelessWidget {
  const MegaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mega - One App For Everything',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MegaHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MegaHomePage extends StatelessWidget {
  const MegaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEGA APP 👑'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BOSS DILEEP MEGA APP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Original concept by dileep, age 15',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Founded October 6, 2026',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 40),
            Text(
              'One App For Everything 🚀',
              style: TextStyle(fontSize: 18, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}

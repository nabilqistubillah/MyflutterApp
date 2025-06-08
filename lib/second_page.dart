import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('Halaman Kedua'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Ini halaman kedua!', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

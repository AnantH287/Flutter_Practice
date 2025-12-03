import 'package:flutter/material.dart';

class IndoorScreen extends StatelessWidget {
  final String token;

  const IndoorScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Indoor Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Indoor Area",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Received JWT Token:"),
            const SizedBox(height: 10),
            Text(token, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

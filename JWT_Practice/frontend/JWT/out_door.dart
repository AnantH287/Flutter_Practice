import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OutdoorScreen extends StatefulWidget {
  final String token;

  const OutdoorScreen({super.key, required this.token});

  @override
  State<OutdoorScreen> createState() => _OutdoorScreenState();
}

class _OutdoorScreenState extends State<OutdoorScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text("Outdoor Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Outdoor Area",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Received JWT Token:"),
            const SizedBox(height: 10),
            Text(widget.token, style: const TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}

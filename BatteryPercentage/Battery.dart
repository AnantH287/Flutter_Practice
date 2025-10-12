import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevelPage extends StatefulWidget {
  const BatteryLevelPage({super.key});

  @override
  State<BatteryLevelPage> createState() => _BatteryLevelPageState();
}

class _BatteryLevelPageState extends State<BatteryLevelPage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Battery level: unknown';

  Future<void> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = 'Battery level: $result%';
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = "Failed to get battery level: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Battery Level")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_batteryLevel),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}

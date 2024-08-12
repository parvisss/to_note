import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_note/ui/screens/auth_checker.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  _PinSetupScreenState createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _storage = FlutterSecureStorage();
  bool _isPinValid = false;

  void _setPin() async {
    final pin = _pinController.text;
    final confirmPin = _confirmPinController.text;

    if (pin.isNotEmpty && pin == confirmPin) {
      await _storage.write(key: 'userPin', value: pin);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthChecker()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PINs do not match.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up PIN'),
        backgroundColor: Colors.orange.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter PIN',
                border: OutlineInputBorder(),
              ),
              maxLength: 4,
              onChanged: (value) {
                setState(() {
                  _isPinValid = value.length == 4;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm PIN',
                border: OutlineInputBorder(),
              ),
              maxLength: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isPinValid ? _setPin : null,
              child: const Text('Save PIN'),
            ),
          ],
        ),
      ),
    );
  }
}

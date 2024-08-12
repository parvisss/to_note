import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_note/ui/screens/auth_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay to show splash screen for 2 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const AuthChecker(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade800,
      body: Center(
        child: Lottie.asset(
          'assets/animations/animation.json',
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

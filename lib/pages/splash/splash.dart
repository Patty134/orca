import 'package:flutter/material.dart';
import 'dart:async';

import 'package:orca/pages/auth/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0, // Adjust this for fade-in effect
          duration: Duration(seconds: 2), // Duration of the fade effect
          child: Text(
            "Loading...",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

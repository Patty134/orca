import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orca/pages/home/home_c.dart';

class SplashF extends StatelessWidget {
  const SplashF({super.key});
  void _navigateWithFade(BuildContext context, Widget targetPage) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => targetPage,
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        try {
          _navigateWithFade(context, HomePage());
        } catch (e) {
          debugPrint("Navigation error: $e");
        }
      });
    });
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animations/plane_splash.json'),
      ),
    );
  }
}

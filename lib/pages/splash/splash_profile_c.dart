import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashProfileC extends StatefulWidget {
  final Widget targetPage;

  const SplashProfileC({super.key, required this.targetPage});

  @override
  _SplashProfileCState createState() => _SplashProfileCState();
}

class _SplashProfileCState extends State<SplashProfileC> {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        try {
          _navigateWithFade(context, widget.targetPage);
        } catch (e) {
          debugPrint("Navigation error: $e");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              'assets/animations/cube_splash.json',
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ],
        ),
      ),
    );
  }
}

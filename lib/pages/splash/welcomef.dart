import 'package:flutter/material.dart';
import 'package:orca/pages/home/home_c.dart';
import 'package:orca/pages/home/home_f.dart';

class WelcomefPage extends StatefulWidget {
  @override
  _WelcomefPageState createState() => _WelcomefPageState();
}

class _WelcomefPageState extends State<WelcomefPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background Image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/Explore.png"), // Your image path
            fit: BoxFit.cover, // Makes the image cover the entire screen
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center all the children
            children: [
              const SizedBox(height: 270), // Space from the top
              // Title Text
              const Text(
                "Your opinion helps us give you the best service.",
                textAlign: TextAlign.center, // Center the title text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 180), // Space between title and subtitle
              // Subtitle Text
              Text(
                "That was interesting, let's start exploring talents.",
                textAlign: TextAlign.center, // Center the subtitle text
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 80), // Space before the button
              // Explore Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FreelancePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Explore →",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomefPage(),
  ));
}

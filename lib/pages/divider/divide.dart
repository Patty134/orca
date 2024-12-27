import 'package:flutter/material.dart';
import 'package:orca/pages/client_side/Preference_C.dart';
import 'package:orca/pages/freelance_side/preference_f.dart';

class ClassifyPage extends StatelessWidget {
  const ClassifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/image/Sectioning.png"), // Path to your image
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 270), // Increased space at the top
            const Text(
              "Whats for today?", // Text above the first button
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color for visibility on the background
              ),
            ),
            const SizedBox(
                height: 30), // Space between the top text and first button
            ElevatedButton(
              onPressed: () {
                // Navigate to HomePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreferencePageC()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 24, 92),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // More rectangular shape
                ),
                elevation: 10, // Adds shadow to the button
                shadowColor: Colors.black, // Shadow color
              ),
              child: const Text(
                "I am a Client",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "OR", // Text between the buttons
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color for visibility on the background
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to HomePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreferencePageF()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 24, 92),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // More rectangular shape
                ),
                elevation: 10, // Adds shadow to the button
                shadowColor: Colors.black, // Shadow color
              ),
              child: const Text(
                "I am a Freelancer",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

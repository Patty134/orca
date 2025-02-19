import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca/logic/controller/auth.dart';
import 'package:orca/pages/client_side/2dIntrests.dart';
import 'package:orca/pages/client_side/preference_C.dart';
import 'package:orca/pages/freelance_side/2dsoftwares.dart';
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
        child: GetBuilder(
            init: AuthController(),
            builder: (ctrl) {
              return Column(
                children: [
                  const SizedBox(height: 270), // Increased space at the top
                  const Text(
                    "Whats for today?", // Text above the first button
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Color for visibility on the background
                    ),
                  ),
                  const SizedBox(
                      height:
                          30), // Space between the top text and first button
                  ElevatedButton(
                    onPressed: () => _apply(ctrl, "client", context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 24, 92),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
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
                      color: Colors
                          .white, // Color for visibility on the background
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _apply(ctrl, "freelancer", context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 24, 92),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
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
              );
            }),
      ),
    );
  }

  void _apply(
      AuthController controller, String identity, BuildContext context) async {
    await controller.loadUserTofirestore(identity);

    if (identity == "client") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TwoDInterestPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TwoDSoftwarePage()),
      );
    }
  }
}

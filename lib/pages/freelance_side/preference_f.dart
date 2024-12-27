import 'package:flutter/material.dart';
import 'package:orca/pages/freelance_side/2dsoftwares.dart';
import 'package:orca/pages/freelance_side/3dsoftwares.dart';

class PreferencePageF extends StatelessWidget {
  const PreferencePageF({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/Client.png"),
                  fit: BoxFit.fill, // Ensures the image fits the screen
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 50, // Position the button 40px from the top
            left: 30, // Position the button 10px from the left
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white, // White color for visibility
                size: 35, // Adjust the size as needed
              ),
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
          ),
          // Content on top of the background image
          Positioned(
            top: 160, // Space between the top and the first button
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  "What do you specialize in?", // Text above the buttons
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.white, // Color for visibility on the background
                  ),
                ),
                const SizedBox(
                    height: 30), // Space between the top text and first button

                // 2D Button with Gradient Background
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TwoDSoftwarePage()),
                    );
                  },
                  child: Container(
                    width: 300, // Increased button width
                    height: 80, // Increased button height
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4, 4),
                          blurRadius: 8,
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 0, 0),
                          Color.fromARGB(255, 130, 0, 0)
                        ], // Gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    child: const Center(
                      child: Text(
                        "2D",
                        style: TextStyle(
                          fontSize: 20, // Increased font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Text after 2D Button with padding
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0), // Adds padding
                  child: Text(
                    "Includes visual art such as video editing and image manipulation, along with Digital Painting and more.", // Text after 2D Button
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Color for visibility on the background
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 3D Button with Gradient Background
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThreeDSoftwarePage()),
                    );
                  },
                  child: Container(
                    width: 300, // Increased button width
                    height: 80, // Increased button height
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4, 4),
                          blurRadius: 8,
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 0, 2, 122),
                          Color.fromARGB(255, 0, 128, 255)
                        ], // Gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    child: const Center(
                      child: Text(
                        "3D",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0), // Adds padding on left and right
                  child: Text(
                    "Includes 3D modeling and rendering techniques, along with immersive virtual environments.", // Text after 3D Button
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Color for visibility on the background
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 3D & 2D Combined Button with Gradient Background
                InkWell(
                  onTap: () {
                    // Add functionality for the 3D & 2D Combined button
                    print("3D & 2D Combined Button Pressed");
                  },
                  child: Container(
                    width: 300, // Increased button width
                    height: 80, // Increased button height
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4, 4),
                          blurRadius: 8,
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 130, 0, 0),
                          Color.fromARGB(255, 0, 128, 255)
                        ], // Gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    child: const Center(
                      child: Text(
                        "BOTH",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0), // Adds padding on left and right
                  child: Text(
                    "A combination of both 2D and 3D arts for comprehensive multimedia projects.", // Text after Combined Button
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Color for visibility on the background
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

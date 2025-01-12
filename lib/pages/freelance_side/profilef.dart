import 'package:flutter/material.dart';
import 'package:orca/pages/home/home_f.dart';

class FreelancerProfilePage extends StatefulWidget {
  const FreelancerProfilePage({Key? key}) : super(key: key);

  @override
  State<FreelancerProfilePage> createState() => _FreelancerProfilePageState();
}

class _FreelancerProfilePageState extends State<FreelancerProfilePage> {
  int _currentIndex = 1; // Default to Profile Page

  // Define the navigation logic for each BottomNav button
  void _navigateToPage(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      Widget targetPage;
      switch (index) {
        case 0:
          targetPage = const FreelancePage(); // Home Page
          break;
        case 1:
          targetPage = const FreelancerProfilePage(); // Profile Page
          break;
        case 2:
          targetPage = const FreelancerProfilePage(); // Settings Page
          break;
        default:
          targetPage = const FreelancerProfilePage();
      }

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => targetPage,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 46, 122, 255), // Blue shade
                  Color.fromARGB(255, 0, 10, 156), // Purple shade
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        _navigateToPage(0); // Navigate to Home Page
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Profile Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0), // Border padding
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5), // Shadow
                                spreadRadius: 8,
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(
                                255, 255, 255, 255), // Border color
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/image/profile_pict.png'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "John Doe",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text(
                          "Graphic Designer & 3D Artist",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Skills Section
                  sectionHeader("Skills"),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: [
                      skillChip("Photoshop"),
                      skillChip("Illustrator"),
                      skillChip("Blender"),
                      skillChip("3D Modeling"),
                      skillChip("Animation"),
                      skillChip("UI/UX Design"),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Experience Section
                  sectionHeader("Experience"),
                  const SizedBox(height: 8),
                  experienceTile("Graphic Designer",
                      "Red Chillies Entertainment", "June 2020 - Present"),
                  experienceTile(
                      "3D Artist", "Sketch Studio", "Jan 2018 - May 2020"),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _navigateToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget skillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.white.withOpacity(0.8),
      labelStyle: const TextStyle(color: Colors.black),
    );
  }

  Widget experienceTile(String title, String company, String duration) {
    return ListTile(
      leading: const Icon(Icons.work, color: Colors.white70),
      title: Text(
        title,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        "$company\n$duration",
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}

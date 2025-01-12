import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/logic/controller/auth.dart';
import 'package:orca/pages/client_side/profilec.dart';
import 'package:orca/pages/home/home_f.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Map<String, String>> imgList = [
    {'image': 'assets/image/pic_1.jpg', 'text': 'Sketching'},
    {'image': 'assets/image/pic_2.jpg', 'text': 'Painting'},
    {'image': 'assets/image/pic_3.jpg', 'text': '3D Model'},
    {'image': 'assets/image/slide4.jpg', 'text': 'Illustration'},
  ];

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  int? _selectedOption = 0;
  AuthController _authController =
      AuthController(); // Initialize AuthController
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isCheckbox1Checked = false;
  bool _isCheckbox2Checked = false;
  bool _isCheckbox3Checked = false;

  void _navigateWithFade(BuildContext context, Widget targetPage) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => targetPage,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  List<File> _files = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _files = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  void _deleteFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 30,
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/image/profile_pict.png'),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 8),
              const Text(
                "Hi User",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 38, 114, 255),
        elevation: 4,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 39, 98, 176),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {
                _navigateWithFade(context, const FreelancePage());
              },
              child: const Text(
                "Switch to Selling",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              // Ensures the container stretches across all available space
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 34, 100, 223), // Light blue
                      Color.fromARGB(255, 192, 215, 255), // white blue
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 130), // Padding to avoid overlap with AppBar
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.8), // Make it slightly transparent
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.6,
                      aspectRatio: 16 / 9,
                    ),
                    items: imgList
                        .map((item) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 300,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item['image']!,
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['text']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 5),
                  const Align(
                    alignment:
                        Alignment.centerLeft, // Align the text to the left
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40.0), // Optional: add left padding if needed
                      child: Text(
                        'Post a Job',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30), // Add left and right padding
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller1,
                        decoration: const InputDecoration(
                          hintText: 'Job Title',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30), // Add left and right padding
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller2,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Job Description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickFiles,
                    child: const Text('Attach File'),
                  ),
                  if (_files.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: _files.asMap().entries.map((entry) {
                          int index = entry.key;
                          File file = entry.value;
                          return Column(
                            children: [
                              file.path.endsWith('.jpg') ||
                                      file.path.endsWith('.jpeg') ||
                                      file.path.endsWith('.png')
                                  ? SizedBox(
                                      width: 100, // Set the desired width
                                      height: 100, // Set the desired height
                                      child:
                                          Image.file(file, fit: BoxFit.cover),
                                    )
                                  : Text(
                                      'Selected file: ${file.path.split('/').last}'),
                              IconButton(
                                icon: const Icon(Icons.close,
                                    color: Color.fromARGB(255, 253, 48, 34)),
                                onPressed: () => _deleteFile(index),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment:
                        Alignment.centerLeft, // Align the text to the left
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40.0), // Same padding as Post a Job
                      child: Text(
                        'Select category',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Radio<int>(
                          // Your existing category selection
                          value: 0,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        const Text('3D'),
                        Radio<int>(
                          value: 1,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        const Text('2D'),
                        Radio<int>(
                          value: 2,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        const Text('Both'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment:
                        Alignment.centerLeft, // Align the text to the left
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40.0), // Same padding as Post a Job
                      child: Text(
                        'Select Field',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('Social Media'),
                          value: _isCheckbox1Checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckbox1Checked = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('Youtube'),
                          value: _isCheckbox2Checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckbox2Checked = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('Web Development'),
                          value: _isCheckbox3Checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckbox3Checked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 19, 95, 255),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Add your button action here
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                30.0), // Add padding inside the button text
                        child: Text(
                          'Post Job',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 95, 255),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                _authController.signOut(context, ref);
                // For example, you could clear user data, navigate to login screen, etc.
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set initial index if needed
        onTap: (int index) {
          setState(() {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (index == 1) {
              print("Cart tapped");
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4.0), // Add padding here
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4.0), // Add padding here
              child: Icon(Icons.chat_rounded),
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4.0), // Add padding here
              child: Icon(Icons.account_circle),
            ),
            label: 'Profile',
          ),
        ],
        backgroundColor: const Color.fromARGB(
            255, 255, 255, 255), // Background color of the bottom nav bar
        selectedItemColor: Colors.black, // Selected icon color
        unselectedItemColor: Colors.black, // Unselected icon color
        showUnselectedLabels: true, // Display unselected labels
        iconSize: 24, // Adjust the icon size if needed
        elevation: 10, // Optional: adjust the elevation of the bottom nav bar
      ),
    );
  }
}

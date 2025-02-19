import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/logic/controller/auth.dart';
import 'package:orca/pages/client_side/profilec.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orca/pages/client_side/showcase/3dmodel.dart';
import 'package:orca/pages/client_side/showcase/illustration.dart';
import 'package:orca/pages/client_side/showcase/painting.dart';
import 'package:orca/pages/client_side/showcase/sketching.dart';
import 'package:orca/pages/splash/splash_profile_c.dart';
import 'package:orca/pages/splash/splashpagec.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final List<Map<String, String>> imgList = [
    {'image': 'assets/image/pic_1.jpg', 'text': 'Sketching'},
    {'image': 'assets/image/pic_2.jpg', 'text': 'Painting'},
    {'image': 'assets/image/pic_3.jpg', 'text': '3D Model'},
    {'image': 'assets/image/slide4.jpg', 'text': 'Illustration'},
  ];

  final jobTitleControl = TextEditingController();
  final jobDescControl = TextEditingController();

  int? _selectedOption = 0;
  AuthController _authController =
      AuthController(); // Initialize AuthController
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isCheckbox1Checked = false;
  bool _isCheckbox2Checked = false;
  bool _isCheckbox3Checked = false;
  final Uuid uuid = Uuid();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Future<String> _generateCustomId() async {
    final DocumentReference counterRef =
        FirebaseFirestore.instance.collection('counters').doc('jobCounter');
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(counterRef);

      if (!snapshot.exists) {
        throw Exception("Counter document does not exist!");
      }

      int currentCounter = snapshot.get('counter');
      int newCounter = currentCounter + 1;
      transaction.update(counterRef, {'counter': newCounter});

      return 'Job_${newCounter.toString().padLeft(4, '0')}';
    });
  }

  Future<List<String>> _uploadFiles(List<File> files) async {
    List<String> downloadUrls = [];
    for (File file in files) {
      String fileName = file.path.split('/').last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('jobs/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
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
                _navigateWithFade(context, const SplashC());
              },
              child: const Text(
                "Switch to Selling",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("User"),
              accountEmail: Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/image/Profile_pic.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _navigateWithFade(context, const HomePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Orders'),
              onTap: () {
                print("Navigating to Orders...");
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {
                  _authController.signOut(context, ref);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white
                  //           .withOpacity(0.8), // Make it slightly transparent
                  //       borderRadius: BorderRadius.circular(12),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.3),
                  //           spreadRadius: 2,
                  //           blurRadius: 5,
                  //           offset: const Offset(0, 3),
                  //         ),
                  //       ],
                  //     ),
                  //     child: const TextField(
                  //       decoration: InputDecoration(
                  //         hintText: 'Search...',
                  //         border: InputBorder.none,
                  //         icon: Icon(Icons.search, color: Colors.black54),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.center, // Align the text to the left
                    child: Text(
                      'Top Services',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                    items: imgList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> item = entry.value;
                      return InkWell(
                        onTap: () {
                          // Handle image click based on index
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashProfileC(
                                    targetPage: SketchingServicesPage()),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashProfileC(
                                    targetPage: PaintingServicesPage()),
                              ),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashProfileC(
                                    targetPage: ThreeDModelsPage()),
                              ),
                            );
                          } else if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashProfileC(
                                    targetPage: IllustrationServicesPage()),
                              ),
                            );
                          }
                        },
                        child: Container(
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
                        ),
                      );
                    }).toList(),
                  ),
                  const Align(
                    alignment:
                        Alignment.centerLeft, // Align the text to the left
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 36.0), // Optional: add left padding if needed
                      child: Text(
                        'Post a Job',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.6),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: jobTitleControl,
                          decoration: InputDecoration(
                            hintText: '   Job Title',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              color: Color.fromARGB(255, 134, 134, 134)),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.6),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: jobDescControl,
                          decoration: InputDecoration(
                            hintText: 'Job Description',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.left,
                        )),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickFiles,
                    child: const Text('Attach Files'),
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
                                      file.path.endsWith('.png') ||
                                      file.path.endsWith('.pdf')
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        const Text('2D'),
                        Radio<int>(
                          value: 1,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        const Text('3D'),
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
                  const SizedBox(height: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isCheckbox1Checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckbox1Checked = value!;
                            });
                          },
                        ),
                        Text('Social Media'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isCheckbox2Checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckbox2Checked = value!;
                            });
                          },
                        ),
                        Text('Youtube'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isCheckbox3Checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckbox3Checked = value!;
                            });
                          },
                        ),
                        Text('Branding'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 19, 95, 255),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          String customId =
                              await _generateCustomId(); // Generate a custom unique ID
                          List<String> downloadUrls = await _uploadFiles(
                              _files); // Upload files and get download URLs
                          CollectionReference collRef =
                              FirebaseFirestore.instance.collection('jobs');
                          await collRef.doc(customId).set({
                            'id':
                                customId, // Store the custom unique ID in the document
                            'images': downloadUrls, // Store the download URLs
                            'jobTitle': jobTitleControl.text,
                            'jobDesc': jobDescControl.text,
                            'category': _selectedOption,
                            'fields': {
                              'SocialMedia': _isCheckbox1Checked,
                              'Youtube': _isCheckbox2Checked,
                              'Branding': _isCheckbox3Checked,
                            },
                          });

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Job posted successfully'),
                            ),
                          );

                          // Clear text fields and reset state
                          jobTitleControl.clear();
                          jobDescControl.clear();
                          setState(() {
                            _selectedOption = 0;
                            _isCheckbox1Checked = false;
                            _isCheckbox2Checked = false;
                            _isCheckbox3Checked = false;
                            _files.clear();
                          });
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
                      const SizedBox(height: 40),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set initial index if needed
        onTap: (int index) {
          if (index == 0) {
            _navigateWithFade(context, SplashProfileC(targetPage: HomePage()));
          } else if (index == 1) {
            print("Cart tapped");
          } else if (index == 2) {
            _navigateWithFade(
                context, SplashProfileC(targetPage: ProfilePage()));
          }
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

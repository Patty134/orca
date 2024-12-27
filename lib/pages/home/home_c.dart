import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:orca/pages/home/home_f.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> imgList = [
    {'image': 'assets/image/slide1.jpg', 'text': 'Sketching'},
    {'image': 'assets/image/slide2.jpg', 'text': 'Painting'},
    {'image': 'assets/image/slide3.jpg', 'text': '3D Model'},
    {'image': 'assets/image/slide4.jpg', 'text': 'Illustration'},
  ];

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  int? _selectedOption = 0;

  bool _isCheckbox1Checked = false;
  bool _isCheckbox2Checked = false;
  bool _isCheckbox3Checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 35,
                onPressed: () {
                  print("Menu Button Pressed");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage:
                      const AssetImage('assets/image/Profile_pic.png'),
                  backgroundColor: Colors.grey[300],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Hi User",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 95, 255),
        elevation: 4,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {
                // Navigate to FreelancePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FreelancePage()),
                );
              },
              child: const Text(
                "Switch to Selling",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/Main_Screen_C.png',
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
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
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
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
                                  const SizedBox(height: 10),
                                  Text(
                                    item['text']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment:
                        Alignment.centerLeft, // Align the text to the left
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0), // Optional: add left padding if needed
                      child: const Text(
                        'Post a Job',
                        style: TextStyle(
                            fontSize: 20,
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
                  const Align(
                    alignment:
                        Alignment.centerLeft, // Align the text to the left
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40.0), // Same padding as Post a Job
                      child: Text(
                        'Select category',
                        style: TextStyle(
                            fontSize: 18,
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
                            fontSize: 18,
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
                          title: const Text('Brand Marketing'),
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: 150, // Makes the button take full width
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle the submit button press
                          print("Form Submitted");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: const Color.fromARGB(
                              255, 0, 50, 90), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
    );
  }
}

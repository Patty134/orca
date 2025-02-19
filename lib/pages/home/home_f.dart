import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:orca/logic/controller/auth.dart';
import 'package:orca/pages/freelance_side/jobdetailspage.dart';
import 'package:orca/pages/freelance_side/profilef.dart';
import 'package:orca/pages/splash/splashpagef.dart';

class FreelancePage extends ConsumerStatefulWidget {
  const FreelancePage({super.key});

  @override
  ConsumerState<FreelancePage> createState() => _FreelancePageState();
}

class _FreelancePageState extends ConsumerState<FreelancePage> {
  AuthController _authController = AuthController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        backgroundColor: const Color.fromARGB(255, 19, 95, 255),
        elevation: 4,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 54, 126),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {
                _navigateWithFade(context, SplashF());
              },
              child: const Text(
                "Switch to Buying",
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
                _navigateWithFade(context, const FreelancePage());
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 33, 95, 211), // Start color
              Color.fromARGB(255, 122, 167, 252), // End color
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Recommended Jobs",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No jobs available'));
                  }

                  final jobs = snapshot.data!.docs;

                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                    ),
                    items: jobs.map((job) {
                      final jobData = job.data() as Map<String, dynamic>;
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width *
                                0.8, // Limit the width of the job card
                            child: jobCard(
                              jobData['jobTitle']?.toString() ?? 'No Title',
                              jobData['jobDesc']?.toString() ??
                                  'No Description',
                              jobData['category']?.toString() ?? 'No Category',
                              Map<String, bool>.from(jobData['fields'] as Map),
                              List<String>.from(jobData['images']
                                  as List), // Pass image URLs to jobCard
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  "Recent Jobs Posted",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No jobs available'));
                  }

                  final jobs = snapshot.data!.docs;

                  return Column(
                    children: jobs.map((job) {
                      final jobData = job.data() as Map<String, dynamic>;
                      return Container(
                        width: double
                            .infinity, // Make the job card fit the width of the screen
                        child: jobCard(
                          jobData['jobTitle']?.toString() ?? 'No Title',
                          jobData['jobDesc']?.toString() ?? 'No Description',
                          jobData['category']?.toString() ?? 'No Category',
                          Map<String, bool>.from(jobData['fields'] as Map),
                          List<String>.from(jobData['images']
                              as List), // Pass image URLs to jobCard
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(2.0),
                child: Icon(Icons.home),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded), label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateWithFade(context, const FreelancePage());
              break;
            case 1:
              // Navigate to Chats page if it exists
              break;
            case 2:
              _navigateWithFade(context, const FreelancerProfilePage());
              break;
          }
        },
      ),
    );
  }

  String truncateDescription(String description, int wordLimit) {
    final words = description.split(' ');
    if (words.length > wordLimit) {
      return words.take(wordLimit).join(' ') + '...';
    }
    return description;
  }

  String mapCategory(String category) {
    switch (category) {
      case '0':
        return '2D';
      case '1':
        return '3D';
      case '2':
        return 'Both';
      default:
        return 'Unknown';
    }
  }

  Widget jobCard(String title, String jobDesc, String category,
      Map<String, bool> fields, List<String> imageUrls) {
    final trueFields = fields.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailPage(
              title: title,
              jobDesc: jobDesc,
              category: mapCategory(category),
              fields: trueFields,
              imageUrls: imageUrls, // Pass imageUrls to JobDetailPage
            ),
          ),
        );
      },
      child: Card(
        color: Colors.blue.shade50,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            // Wrap the Column with SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(truncateDescription(jobDesc, 10)),
                const SizedBox(height: 8),
                Text(mapCategory(category)),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: trueFields.map((field) => Text(field)).toList(),
                ),
                const SizedBox(
                    height: 1), // Add a small height to prevent overflow
              ],
            ),
          ),
        ),
      ),
    );
  }
}

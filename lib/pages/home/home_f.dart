import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/logic/controller/auth.dart';
import 'package:orca/pages/client_side/profilec.dart';
import 'package:orca/pages/freelance_side/profilef.dart';
import 'package:orca/pages/home/home_c.dart';

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
              color: Colors.purple,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {
                _navigateWithFade(context, const HomePage());
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SizedBox(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Recommended Job",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  jobCard("Graphic Designer", "Red Chillies Entertainment",
                      "Mumbai  ", "Full-Time  ", "2-3 Years"),
                  jobCard("Sketching Artist", "Sketch Studio", "Bangalore  ",
                      "Full-Time  ", "2 Years"),
                  jobCard("Blender Artist", "Red-Chillies", "Mumbai  ",
                      "Full-Time  ", "3 Years"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "New Posted Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                jobCard(
                    "Illustrator", "Zomato", "Mumbai", "Part-Time", "2 Years"),
                jobCard("Roto Artist", "GT Studio", "Bangalore", "Full-Time",
                    "5 Years"),
                jobCard("Sketching Artist", "Blinkit", "Mumbai", "Full-Time",
                    "2 Years"),
                jobCard("Blender Artist", "Red-Chillies", "Mumbai", "Full-Time",
                    "3 Years"),
                const SizedBox(height: 20),
              ],
            ),
          ],
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

  Widget jobCard(String title, String company, String location, String type,
      String experience) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      shadowColor: Colors.grey.withOpacity(0.3),
      color: Colors.lightBlue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 5),
            Text(company,
                style: TextStyle(
                    color: Colors.grey.shade600, fontSize: 14, height: 1.5)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(location,
                    style: TextStyle(
                        fontSize: 12, color: Colors.blueGrey.shade600)),
                Text(type,
                    style: TextStyle(
                        fontSize: 12, color: Colors.blueGrey.shade600)),
                Text(experience,
                    style: TextStyle(
                        fontSize: 12, color: Colors.blueGrey.shade600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

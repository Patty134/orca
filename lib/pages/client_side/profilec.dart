import 'package:flutter/material.dart';
import 'package:orca/pages/home/home_c.dart';
import 'package:orca/pages/splash/splash_profile_c.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 100, 223), // Light blue
                    Color.fromARGB(255, 192, 215, 255), // White blue
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SplashProfileC(targetPage: HomePage()),
                            ),
                          );
                        },
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/image/Profile_pic.png'), // Profile picture
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'James Brown',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Manager at Wix Studio',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, indent: 16, endIndent: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.email, color: Colors.black),
                      title: Text('Email'),
                      subtitle: Text('jamesbrown@gmail.com'),
                    ),
                  ),
                  const Divider(color: Colors.grey, indent: 16, endIndent: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.phone, color: Colors.black),
                      title: Text('Mobile'),
                      subtitle: Text('9866422971'),
                    ),
                  ),
                  const Divider(color: Colors.grey, indent: 16, endIndent: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.alternate_email, color: Colors.black),
                      title: Text('Twitter'),
                      subtitle: Text('@jamesb2'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // First Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius:
                              20, // You can adjust the radius to control the size
                          child: ClipOval(
                            child: Image.asset(
                              'assets/image/zomato-logo.png',
                              fit: BoxFit
                                  .contain, // Ensures the image fits within the circle without cropping
                            ),
                          ),
                        ),
                        title: const Text('Illustrator'),
                        subtitle: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Zomato'),
                          ],
                        ),
                        trailing: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.work, size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('Part-Time'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('Mumbai'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('2 Years'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Second Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius:
                              20, // You can adjust the radius to control the size
                          child: ClipOval(
                            child: Image.asset(
                              'assets/image/uber_logo.png',
                              fit: BoxFit
                                  .contain, // Ensures the image fits within the circle without cropping
                            ),
                          ),
                        ),
                        title: const Text('Designer'),
                        subtitle: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Uber'),
                          ],
                        ),
                        trailing: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.work, size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('Full-Time'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('Delhi'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('3 Years'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Third Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius:
                              20, // You can adjust the radius to control the size
                          child: ClipOval(
                            child: Image.asset(
                              'assets/image/airbnb_logo.png',
                              fit: BoxFit
                                  .contain, // Ensures the image fits within the circle without cropping
                            ),
                          ),
                        ),
                        title: const Text('Web Developer'),
                        subtitle: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Airbnb'),
                          ],
                        ),
                        trailing: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.work, size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('Intern'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('Bangalore'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text('6 Months'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orca/data/model/auth.dart';
import 'package:orca/data/model/preferences.dart';
import 'package:orca/data/storage/user_Data.dart';
import 'package:orca/pages/client_side/profile_con.dart';
import 'package:orca/pages/home/home_c.dart';
import 'package:orca/pages/splash/splash_profile_c.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore _userStore = UserStore();
  UserModel _userModel = UserModel();
  List<String> _preferences = [];

  @override
  void initState() {
    super.initState();
    loadUser();
    _loadPreferences();
  }

  Future<void> loadUser() async {
    _userModel = await _userStore.loadData();
    setState(() {});
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedPreferences = prefs.getStringList('preferences');

    if (cachedPreferences != null) {
      setState(() {
        _preferences = cachedPreferences;
      });
    } else {
      _fetchPreferences();
    }
  }

  Future<void> _fetchPreferences() async {
    // Get the current user's UID
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is signed in");
      return;
    }
    String userId = user.uid;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("preferences")
          .doc(userId)
          .collection("Intrests")
          .doc("Topics")
          .get();

      if (doc.exists) {
        List<String> preferences = List<String>.from(doc["selection"]);
        setState(() {
          _preferences = preferences;
        });

        // Cache the preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setStringList('preferences', preferences);
      } else {
        print("No preferences found for this user");
      }
    } on FirebaseException catch (e) {
      print("Error fetching preferences: ${e.message}");
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 67, 192), // Light blue
              Color.fromARGB(255, 192, 215, 255), // White blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
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
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                      Text(
                        _userModel.name != null
                            ? _userModel.name ?? ""
                            : "User",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _userModel.description != null &&
                                _userModel.description!.isNotEmpty
                            ? _userModel.description ?? ""
                            : "Manager at Wix Studio",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                          color: Colors.grey, indent: 16, endIndent: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListTile(
                          leading: Icon(Icons.email, color: Colors.black),
                          title: Text("Email"),
                          subtitle: Text(_userModel.email != null &&
                                  _userModel.email!.isNotEmpty
                              ? _userModel.email ?? ""
                              : "abc@gmai.com"),
                        ),
                      ),
                      const Divider(
                          color: Colors.grey, indent: 16, endIndent: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListTile(
                          leading: Icon(Icons.phone, color: Colors.black),
                          title: Text('Mobile'),
                          subtitle: Text(_userModel.phone != null &&
                                  _userModel.phone!.isNotEmpty
                              ? _userModel.phone ?? ""
                              : "no Phone number"),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                      const Divider(
                          color: Colors.grey, indent: 16, endIndent: 16),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'My Interests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Wrap(
                          spacing: 10,
                          children: _preferences
                              .map((preference) => skillChip(preference))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  Widget skillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.white.withOpacity(0.8),
      labelStyle: const TextStyle(color: Colors.black),
    );
  }
}

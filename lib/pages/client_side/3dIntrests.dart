import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orca/pages/welcome.dart';

class ThreeDInterestPage extends StatefulWidget {
  const ThreeDInterestPage({super.key});

  @override
  _ThreeDInterestPageState createState() => _ThreeDInterestPageState();
}

class _ThreeDInterestPageState extends State<ThreeDInterestPage> {
  final List<String> _options = [
    '3D Modeling',
    '3d Environment',
    '3d Animation',
    '3d Product Rendering',
    '3d Graphic Design',
    'Game Asset Design',
  ];

  late List<bool> _checkboxValues;

  @override
  void initState() {
    super.initState();
    _checkboxValues = List.generate(_options.length, (index) => false);
  }

  // This method logs selected options and navigates to WelcomePage
  Future<void> _submit() async {
    print('Selected checkboxes:');

    List<String> selectedOptions = [];
    for (int i = 0; i < _checkboxValues.length; i++) {
      if (_checkboxValues[i]) {
        selectedOptions.add(_options[i]);
      }
    }

    await sendToUserDoc(selectedOptions);
    // Navigate to WelcomePage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  Future<void> sendToUserDoc(List<String> selectedOptions) async {
    // Get the current user's UID
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is signed in");
      return;
    }
    String userId = user.uid;

    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("preferences").doc(userId);

      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        Map<String, dynamic> existingData = doc.data() as Map<String, dynamic>;
        List<String> existingSelections = [];
        if (existingData.containsKey("selection")) {
          existingSelections = List<String>.from(existingData["selection"]);
        }
        existingSelections.addAll(selectedOptions);
        selectedOptions =
            existingSelections.toSet().toList(); // Remove duplicates
      }

      await docRef.set({"selection": selectedOptions}, SetOptions(merge: true));
      print("Data sent to Firestore");
    } on FirebaseException catch (e) {
      print("Error sending data to Firestore: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/IntrestsC.png"),
                  fit: BoxFit.cover, // Makes the image cover the screen
                ),
              ),
            ),
          ),
          // Back Button without AppBar
          Positioned(
            top: 50, // Adjusted position of the back button
            left: 30,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black, // Black color for visibility
                size: 35, // Adjust the size as needed
              ),
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
          ),
          // Main Content (Text and Checkboxes)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0), // Added padding on left and right
                    child: Text(
                      'What are your 3D Interests?',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Space between text and checkboxes

                  // Generate checkboxes from the _options list
                  ..._options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0), // Padding on left and right
                      child: CheckboxListTile(
                        title: Text(
                          option,
                          style: const TextStyle(
                              color: Colors.white), // White text color
                        ),
                        value: _checkboxValues[index],
                        activeColor: Colors.green, // Brighter active color
                        checkColor: Colors.white, // White check mark
                        controlAffinity: ListTileControlAffinity
                            .leading, // Align checkbox to the left
                        onChanged: (bool? value) {
                          setState(() {
                            _checkboxValues[index] = value!;
                          });
                        },
                        tileColor: Colors.black.withOpacity(
                            0.5), // Add background color to each checkbox
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Rounded corners for the checkbox tile
                          side: BorderSide(
                              color: Colors.white.withOpacity(0.6),
                              width: 2), // Add a border around checkbox
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20), // Space before submit button

                  // Align the submit button to the right with padding
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Align button to the right
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0), // Padding on the right side
                        child: ElevatedButton(
                          onPressed: () async =>
                              _submit(), // Call the _submit method when pressed
                          child: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // White background for the button
                            foregroundColor: Colors.black, // Black text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

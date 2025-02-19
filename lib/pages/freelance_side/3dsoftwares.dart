import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orca/data/model/preferences.dart';
import 'package:orca/data/storage/user_Data.dart';
import 'package:orca/pages/splash/welcomef.dart';
import 'package:orca/pages/welcome.dart';

class ThreeDSoftwarePage extends StatefulWidget {
  const ThreeDSoftwarePage({super.key});

  @override
  _ThreeDSoftwarePageState createState() => _ThreeDSoftwarePageState();
}

class _ThreeDSoftwarePageState extends State<ThreeDSoftwarePage> {
  final List<String> _options = [
    '3ds Max/Maya',
    'Cinema 4d',
    'Blender',
    'Unreal Engine',
    'Sketchup',
    'Clo3d',
    'Z-Brush',
    'Houdini',
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
    List<Map<String, bool>> selectedOptions = [];
    for (int i = 0; i < _checkboxValues.length; i++) {
      if (_checkboxValues[i]) {
        print(_options[i]);
        selectedOptions.add({_options[i]: true});
      }
    }

    // Navigate to WelcomePage1
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  Future<void> sendToUserDoc(PreferencesModel preference) async {
    UserStore _userStore = UserStore();
    final usermodel = await _userStore.loadData();
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(usermodel.id)
          .set({"preferences": {}}, SetOptions(merge: true));
      print("Data sent to firestore");
    } on FirebaseException catch (e) {
      print("Error sending data to firestore: ${e.message}");
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
                      'What are your Software?',
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
                          onPressed:
                              _submit, // Call the _submit method when pressed
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/pages/welcome.dart';

// StateNotifier for managing checkbox states
class CheckboxStateNotifier extends StateNotifier<List<bool>> {
  CheckboxStateNotifier(int length) : super(List.filled(length, false));

  void toggleCheckbox(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) !state[i] else state[i],
    ];
  }
}

// Provider for 3D Interests
final threeDCheckboxProvider =
    StateNotifierProvider<CheckboxStateNotifier, List<bool>>(
        (ref) => CheckboxStateNotifier(6)); // Adjust the length as per options

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

  void _submit(BuildContext context, WidgetRef ref) {
    final checkboxValues = ref.read(threeDCheckboxProvider);
    print('Selected 3D Interests:');
    for (int i = 0; i < checkboxValues.length; i++) {
      if (checkboxValues[i]) {
        print('${_options[i]} selected');
      }
    }

    // Navigate to WelcomePage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final checkboxValues = ref.watch(threeDCheckboxProvider);

        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/IntrestsC.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Back Button
              Positioned(
                top: 50,
                left: 30,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Main Content
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'What are your 3D Interests?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Checkboxes
                      ..._options.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CheckboxListTile(
                            title: Text(
                              option,
                              style: const TextStyle(color: Colors.white),
                            ),
                            value: checkboxValues[index],
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? value) {
                              ref
                                  .read(threeDCheckboxProvider.notifier)
                                  .toggleCheckbox(index);
                            },
                            tileColor: Colors.black.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.6),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      // Submit Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: ElevatedButton(
                              onPressed: () => _submit(context, ref),
                              child: const Text('Submit'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
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
      },
    );
  }
}

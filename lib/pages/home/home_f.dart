import 'package:flutter/material.dart';
import 'package:orca/pages/home/home_c.dart';

class FreelancePage extends StatefulWidget {
  const FreelancePage({super.key});

  @override
  State<FreelancePage> createState() => _FreelancePageState();
}

class _FreelancePageState extends State<FreelancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 200, // Adjust width to fit all items properly
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 30,
                onPressed: () {
                  print("Menu Button Pressed");
                },
              ),
              const SizedBox(width: 8), // Add consistent spacing
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/image/Profile_pic.png'),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 8), // Adjust spacing to reduce the gap
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
                // Navigate to HomePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text(
                "Switch to Buying",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) {
          String label = ['Home', 'Jobs', 'Profile'][index];
          print('$label button clicked');
        },
      ),
    );
  }

  Widget jobCard(String title, String company, String location, String type,
      String experience) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      elevation: 6, // Adding shadow effect
      shadowColor: Colors.grey.withOpacity(0.3),
      color:
          Colors.lightBlue.shade100, // Sky blue color for the card background
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

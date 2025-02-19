import 'package:flutter/material.dart';
import 'package:orca/pages/home/home_c.dart';

class ChatPageC extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageC>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> chats = [
    {
      "name": "John Doe",
      "message": "Hey, how are you?",
      "time": "2m",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Jane Smith",
      "message": "Let's catch up tomorrow.",
      "time": "10m",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Emily Brown",
      "message": "See you at the event!",
      "time": "30m",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "John Doe",
      "message": "Hey, how are you?",
      "time": "2m",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "John Doe",
      "message": "Hey, how are you?",
      "time": "2m",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "John Doe",
      "message": "Hey, how are you?",
      "time": "2m",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
    {
      "name": "Chris Johnson",
      "message": "Got your message, thanks!",
      "time": "1h",
      "image": "assets/image/profile_pict.png"
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _navigateWithFade(context, HomePage());
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 185, 185),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 185, 185), // white blue
                Color.fromARGB(255, 123, 164, 240), // Light blue
              ],
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(chat['image']!),
                    ),
                    title: Text(chat['name']!),
                    subtitle: Text(chat['message']!),
                    trailing: Text(chat['time']!),
                  );
                },
              ),
              const Center(child: Text('Contacts')),
              const Center(child: Text('Settings')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65, // Set the desired height
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: SizedBox(height: 20, child: Icon(Icons.home, size: 20)),
              text: 'Home',
            ),
            Tab(
              icon: SizedBox(height: 20, child: Icon(Icons.chat, size: 20)),
              text: 'Chats',
            ),
            Tab(
              icon: SizedBox(height: 20, child: Icon(Icons.person, size: 20)),
              text: 'Profile',
            ),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.blue,
          labelStyle: const TextStyle(
              fontSize: 12), // Set the font size for the selected tab
          unselectedLabelStyle: const TextStyle(
              fontSize: 12), // Set the font size for the unselected tabs
        ),
      ),
    );
  }
}

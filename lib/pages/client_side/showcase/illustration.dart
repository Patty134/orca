import 'package:flutter/material.dart';

class IllustrationServicesPage extends StatefulWidget {
  @override
  _IllustrationServicesPageState createState() =>
      _IllustrationServicesPageState();
}

class _IllustrationServicesPageState extends State<IllustrationServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Illustration Services'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Explore Our Illustration Services',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'From character designs to book illustrations, we craft vibrant visuals to bring your ideas to life.',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade600),
              ),
              SizedBox(height: 16),

              // Character Illustration
              _buildServiceCard(
                title: 'Character Illustration',
                description:
                    'Bring unique characters to life with detailed and vibrant character illustrations tailored to your needs.',
                imagePath: 'assets/showcase/charachter_illustration.png',
              ),
              SizedBox(height: 16),

              // Book Illustration
              _buildServiceCard(
                title: 'Book Illustration',
                description:
                    'Enhance your stories with captivating book illustrations, perfect for children’s books, novels, and more.',
                imagePath: 'assets/showcase/book_illustration.png',
              ),
              SizedBox(height: 16),

              // Concept Art
              _buildServiceCard(
                title: 'Concept Art',
                description:
                    'Visualize your ideas with stunning concept art, ideal for games, films, and creative projects.',
                imagePath: 'assets/showcase/concept_art.png',
              ),
              SizedBox(height: 16),

              // Technical Illustration
              _buildServiceCard(
                title: 'Technical Illustration',
                description:
                    'Precise and informative technical illustrations designed for manuals, guides, and educational materials.',
                imagePath: 'assets/showcase/technical_illustration.png',
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: Text(
                  'Illustrating your vision, one stroke at a time!',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
            ),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

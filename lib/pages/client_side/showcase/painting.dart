import 'package:flutter/material.dart';

class PaintingServicesPage extends StatefulWidget {
  @override
  _PaintingServicesPageState createState() => _PaintingServicesPageState();
}

class _PaintingServicesPageState extends State<PaintingServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painting Services'),
        backgroundColor: const Color.fromARGB(255, 43, 133, 252),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Discover Our Painting Services',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We bring your vision to life with beautiful painting styles. Whether landscapes, portraits, abstracts, or custom designs, we’ve got you covered!',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade600),
              ),
              SizedBox(height: 16),

              // Landscape Painting
              _buildServiceCard(
                title: 'Landscape Painting',
                description:
                    'Capture the beauty of nature with our stunning landscape paintings. Perfect for decorating your home or office.',
                imagePath: 'assets/showcase/Landscape_painting.png',
              ),
              SizedBox(height: 16),

              // Portrait Painting
              _buildServiceCard(
                title: 'Portrait Painting',
                description:
                    'Immortalize cherished moments or loved ones with our highly detailed and personalized portrait paintings.',
                imagePath: 'assets/showcase/portrait_painting.png',
              ),
              SizedBox(height: 16),

              // Abstract Painting
              _buildServiceCard(
                title: 'Abstract Painting',
                description:
                    'Add a modern and creative touch to your space with unique abstract artwork crafted by skilled artists.',
                imagePath: 'assets/showcase/abstract_painting.png',
              ),
              SizedBox(height: 16),

              // Custom Painting
              _buildServiceCard(
                title: 'Custom Painting',
                description:
                    'Bring your ideas to life with custom paintings tailored to your preferences and style.',
                imagePath: 'assets/showcase/custom_painting.png',
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: Text(
                  'We make every stroke count!',
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

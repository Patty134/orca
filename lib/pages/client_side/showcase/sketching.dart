import 'package:flutter/material.dart';

class SketchingServicesPage extends StatefulWidget {
  @override
  _SketchingServicesPageState createState() => _SketchingServicesPageState();
}

class _SketchingServicesPageState extends State<SketchingServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sketching Services'),
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
                'Discover Our Sketching Services',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our sketches bring your imagination to life. From portraits to architectural designs, explore the art of lines and shadows.',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade600),
              ),
              SizedBox(height: 16),

              // Pencil Sketching
              _buildServiceCard(
                title: 'Pencil Sketching',
                description:
                    'Delicate and detailed pencil sketches that capture realism and intricacies with precision.',
                imagePath: 'assets/showcase/pencil_sketching.png',
              ),
              SizedBox(height: 16),

              // Charcoal Sketching
              _buildServiceCard(
                title: 'Charcoal Sketching',
                description:
                    'Bold and dramatic charcoal sketches that bring out striking contrasts and depth.',
                imagePath: 'assets/showcase/charcoal_sketching.png',
              ),
              SizedBox(height: 16),

              // Digital Sketching
              _buildServiceCard(
                title: 'Digital Sketching',
                description:
                    'Modern digital sketches crafted using advanced tools for high-quality and versatile results.',
                imagePath: 'assets/showcase/digital_sketching.png',
              ),
              SizedBox(height: 16),

              // Architectural Sketching
              _buildServiceCard(
                title: 'Architectural Sketching',
                description:
                    'Intricate architectural sketches that showcase structures and spaces with accuracy and creativity.',
                imagePath: 'assets/showcase/architectural_sketching.png',
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: Text(
                  'Sketching your imagination, one line at a time!',
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

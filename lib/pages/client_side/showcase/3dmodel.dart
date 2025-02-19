import 'package:flutter/material.dart';

class ThreeDModelsPage extends StatefulWidget {
  @override
  _ThreeDModelsPageState createState() => _ThreeDModelsPageState();
}

class _ThreeDModelsPageState extends State<ThreeDModelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D Models Services'),
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
                'Our 3D Modeling Services',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Explore our diverse range of 3D modeling services, perfect for animation, architecture, and more.',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade600),
              ),
              SizedBox(height: 16),

              // Character Modeling
              _buildServiceCard(
                title: 'Character Modeling',
                description:
                    'Realistic and stylized 3D character models for animation, gaming, and film production.',
                imagePath: 'assets/showcase/charachter_modelling.png',
              ),
              SizedBox(height: 16),

              // Architectural Modeling
              _buildServiceCard(
                title: 'Architectural Modeling',
                description:
                    'Detailed 3D models for visualizing buildings, interiors, and landscapes.',
                imagePath: 'assets/showcase/architectural_modelling.png',
              ),
              SizedBox(height: 16),

              // Product Modeling
              _buildServiceCard(
                title: 'Product Modeling',
                description:
                    'High-quality 3D models for product visualization, marketing, and prototyping.',
                imagePath: 'assets/showcase/product_modelling.png',
              ),
              SizedBox(height: 16),

              // Animation Assets
              _buildServiceCard(
                title: 'Animation Assets',
                description:
                    'Customized 3D assets for use in animated videos, games, and other creative projects.',
                imagePath: 'assets/showcase/animation_asstes.png',
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: Text(
                  'Creating dimensions that define your ideas!',
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

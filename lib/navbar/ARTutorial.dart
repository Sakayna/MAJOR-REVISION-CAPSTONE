import 'package:flutter/material.dart';

class ARTutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the AR Tutorial!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Here, you will learn how to use Augmented Reality features in this app.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Add additional AR tutorial content here
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GraphCard extends StatelessWidget {
  final String title;
  // final VoidCallback onTap;
  final String imagePath;
  final int itemCount;
  final int takeCount;

  GraphCard({
    required this.title,
    // required this.onTap,
    required this.itemCount,
    required this.takeCount,
    this.imagePath = 'assets/images/placeholder.png',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        // onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  // height: 0.8,
                ),
              ),
              Text(
                itemCount > 0 && takeCount > 0
                    ? "$itemCount Item${itemCount > 1 ? 's' : ''} • $takeCount Take${takeCount > 1 ? 's' : ''}"
                    : "No Record",
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

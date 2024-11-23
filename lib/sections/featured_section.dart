import 'package:flutter/material.dart';

class FeaturedServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Our Services',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ServiceCard(
              //   // imagePath: 'assets/custom_clothing.jpg',
              //   title: 'Custom Clothing',
              // ),
              // ServiceCard(
              //   imagePath: 'assets/fabric_selection.jpg',
              //   title: 'Fabric Selection',
              // ),
              // ServiceCard(
              //   imagePath: 'assets/virtual_fitting.jpg',
              //   title: 'Virtual Fitting Room',
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;

  ServiceCard({required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 100, height: 100),
        SizedBox(height: 10),
        Text(title),
      ],
    );
  }
}

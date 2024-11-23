import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'How It Works',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepCard(step: 'Choose Fabric', icon: Icons.shop),
              StepCard(step: 'Enter Measurements', icon: Icons.rule),
              StepCard(step: 'Customize Design', icon: Icons.design_services),
              StepCard(step: 'Place Order', icon: Icons.shopping_cart),
            ],
          ),
        ],
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final String step;
  final IconData icon;

  StepCard({required this.step, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 50),
        SizedBox(height: 10),
        Text(step),
      ],
    );
  }
}

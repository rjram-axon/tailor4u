import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   'assets/hero_bg.jpg',
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   height: 300,
        // ),
        Positioned(
          left: 20,
          top: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Perfect Fit Awaits',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: Text('Start Designing'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

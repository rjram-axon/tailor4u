import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Quick Links',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Home', style: TextStyle(color: Colors.white)),
              Text('Privacy Policy', style: TextStyle(color: Colors.white)),
              Text('Terms of Service', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Contact Us',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text('Email: info@tailor4u.com',
              style: TextStyle(color: Colors.white)),
          Text('Phone: (123) 456-7890', style: TextStyle(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.facebook, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.facebook, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.facebook, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Image.asset('assets/logo.png'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () {}, child: Text('Home')),
          TextButton(onPressed: () {}, child: Text('About')),
          TextButton(onPressed: () {}, child: Text('Services')),
          TextButton(onPressed: () {}, child: Text('Tailors')),
          TextButton(onPressed: () {}, child: Text('Contact')),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.account_circle, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}

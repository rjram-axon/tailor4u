import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tailor4U',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroSection(),
            SectionDivider(),
            SectionTitle(title: 'Our Services'),
            FeaturedServices(),
            SectionDivider(),
            SectionTitle(title: 'How It Works'),
            HowItWorks(),
            SectionDivider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            // image: DecorationImage(
            //   // image: AssetImage('assets/hero_bg.jpg'),
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover Our Collection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                CarouselWithExploreButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CarouselWithExploreButton extends StatelessWidget {
  final List<String> imgList = [
    'assets/item1.png',
    'assets/item2.png',
    'assets/item3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        autoPlayInterval: Duration(seconds: 3),
      ),
      items: imgList.map((item) => buildCarouselCard(item)).toList(),
    );
  }

  Widget buildCarouselCard(String imgPath) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {
            // Implement navigation to item details or exploration page
          },
          child: Text('Explore'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Colors.grey[300],
        thickness: 1,
      ),
    );
  }
}

class FeaturedServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ServiceCard(
            icon: Icons.design_services,
            title: 'Custom Clothing',
          ),
          ServiceCard(
            icon: Icons.shop,
            title: 'Fabric Selection',
          ),
          ServiceCard(
            icon: Icons.shop,
            title: 'Virtual Fitting Room',
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;

  ServiceCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          StepCard(
            step: 'Choose Fabric',
            icon: Icons.shop,
          ),
          StepCard(
            step: 'Enter Measurements',
            icon: Icons.rule,
          ),
          StepCard(
            step: 'Customize Design',
            icon: Icons.design_services,
          ),
          StepCard(
            step: 'Place Order',
            icon: Icons.shopping_cart,
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 50, color: Colors.green),
            SizedBox(width: 20),
            Text(
              step,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

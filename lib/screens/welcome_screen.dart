import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tailor4u/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // White Background
          Container(
            color: Colors.white,
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  // Logo or Image (replace with your logo or image widget)
                  // Image.asset(
                  //   'assets/your_logo.png', // Replace with your logo asset path
                  //   height: screenHeight * 0.2,
                  //   // Adjust height as needed
                  // ),
                  SizedBox(height: screenHeight * 0.1),
                  // Carousel
                  CarouselSlider(
                    options: CarouselOptions(
                      height: screenHeight * 0.3,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: [
                      'assets/placeholder1.png',
                      'assets/placeholder2.png'
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                i,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Text Content with Fade Transition
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          "Tailor On Your Doorstep",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6F4F99), // Dark purple
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Pickup · Stitch · Deliver",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Colors.grey,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFF6F4F99), // Dark purple
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // Handle button click
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Mobileverify(),
                                  ),
                                );
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

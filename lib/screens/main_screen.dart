import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import smooth_page_indicator package

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Create a PageController for the carousel
  final PageController _carouselController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Icon(Icons.person_outline_rounded),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "BLOUSE CRAFT",
            style: TextStyle(color: Colors.black, fontFamily: 'Outfit-Regular'),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Profile section below AppBar
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile Avatar and Welcome Text
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20, // Profile icon size
                          backgroundColor: Color(0xFFE747D2),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Welcome Jeyaram", // Replace with dynamic name
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit-Regular',
                          ),
                        ),
                      ],
                    ),
                    // Notification Icon in CircleAvatar
                    CircleAvatar(
                      radius: 16, // Match the size of the profile avatar
                      backgroundColor: Color(0xFFE747D2),
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 17,
                        ),
                        onPressed: () {
                          // Add your notification logic here
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      bottom: 80), // Prevent content overlap
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar
                        SizedBox(
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              isDense: true, // Ensures compact layout
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Categories
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextButton(
                              onPressed: () {},
                              child: Text("See all"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Filters
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilterChip(
                              label: Text("All"),
                              selected: true,
                              onSelected: (selected) {},
                            ),
                            FilterChip(
                              label: Text("New collection"),
                              selected: false,
                              onSelected: (selected) {},
                            ),
                            FilterChip(
                              label: Text("Trending"),
                              selected: false,
                              onSelected: (selected) {},
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Carousel with adjusted properties
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.85,
                            onPageChanged: (index, reason) {
                              // You can update the SmoothPageIndicator here if necessary
                              setState(
                                  () {}); // Forces a rebuild to reflect the page change
                            },
                          ),
                          items: [
                            // Carousel Item 1
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Colors.blueAccent,
                                child: Center(
                                  child: Text(
                                    "Carousel Item 1",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            // Carousel Item 2
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    "Carousel Item 2",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            // Carousel Item 3
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Colors.orangeAccent,
                                child: Center(
                                  child: Text(
                                    "Carousel Item 3",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SmoothPageIndicator to customize the dot position
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 130,
                              top: 10), // Adjust the padding for dot position
                          child: SmoothPageIndicator(
                            controller:
                                _carouselController, // Use the same controller
                            count: 3, // Number of items in the carousel
                            effect: ExpandingDotsEffect(
                              dotWidth: 8,
                              dotHeight: 8,
                              expansionFactor: 4,
                              spacing: 16,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.pink,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Products Grid
                        GridView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // Prevent scrolling inside GridView
                          shrinkWrap: true, // Adjust size to fit children
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[300],
                                      // Placeholder for product image
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "BLOUSE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text("₹1300",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(width: 8),
                                            Text(
                                              "₹1500",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.pink, size: 16),
                                            SizedBox(width: 4),
                                            Text("4.0"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Floating Bottom Navigation Bar
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavBarItem(Icons.home, "Home", Colors.pink),
                    _buildNavBarItem(Icons.shopping_bag, "Orders", Colors.grey),
                    _buildNavBarItem(
                        Icons.grid_view, "Categories", Colors.grey),
                    _buildNavBarItem(Icons.person, "Profile", Colors.grey),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'
    as carousel_slider; // Import carousel_slider package
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor4u/authentication/profile_service.dart';
import 'package:tailor4u/screens/categorydetails.dart';
import 'package:tailor4u/screens/orderdetails.dart';
import 'package:tailor4u/screens/product_details.dart';
import 'package:tailor4u/screens/profile.dart';
import 'package:tailor4u/sections/app_theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  // Create a PageController for the carousel
  final CarouselController carouselController = CarouselController();
  int _activeIndex = 0;
  int _swipeCount = 0; // Track the number of swipes
  DateTime? _lastSwipeTime; // To track the time of the last swipe
  String profilePic = 'assets/item1.png'; // Default profile pic
  final ProfileService _profileService = ProfileService();
  String name = '';
  String selectedSortOption = 'Price: Low to High';

  int cartItemCount = 0; // To track cart items count

  void updateCartCount(int count) {
    setState(() {
      cartItemCount = count;
    });
  }

  void sortItems() {
    if (selectedSortOption == 'Price: Low to High') {
      // Implement sorting logic for price low to high
    } else if (selectedSortOption == 'Price: High to Low') {
      // Implement sorting logic for price high to low
    } else if (selectedSortOption == 'Newest') {
      // Implement sorting logic for newest items
    } else if (selectedSortOption == 'Popularity') {
      // Implement sorting logic for popularity
    }
  }

  Future<void> _fetchProfile() async {
    // Get the mobile number from UserService
    String? mobNum = await _profileService.getProcessedMobileNumber();
    if (mobNum != null) {
      await _profileService.loadFromLocalStorage(); // Load from local storage
      setState(() {
        name = ProfileService().name;
        profilePic = ProfileService().profilePic;
      });
    } else {
      setState(() {
        name = 'Mobile number not available';
      });
    }
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  // Function to handle swipe logic
  void _handleSwipe() {
    final now = DateTime.now();
    if (_lastSwipeTime == null ||
        now.difference(_lastSwipeTime!) > const Duration(seconds: 2)) {
      // Reset the swipe count if more than 2 seconds have passed since the last swipe
      _swipeCount = 0;
    }

    _lastSwipeTime = now;
    _swipeCount++;

    if (_swipeCount >= 2) {
      // Close the app after two swipes
      SystemNavigator.pop();
    } else {
      // Provide feedback to the user (like a message or toast) if they haven't swiped twice yet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Swipe again to exit the app")),
      );
    }
  }

  void _showBottomDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the sheet height flexible
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF8E1F4), // Soft lavender background
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...[
                'Price: Low to High',
                'Price: High to Low',
                'Newest',
                'Popularity'
              ].map((option) {
                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontFamily: 'Outfit-Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBE359C),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedSortOption = option; // Update the selected option
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the back gesture from being triggered
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50), // Set the height explicitly
          child: AppBar(
            toolbarHeight:
                50, // Ensures the toolbar height is exactly as desired
            backgroundColor: AppTheme.primaryColor,
            elevation: 1,
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                "TAILUX",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontFamily: 'Sheina',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 7
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              // Detect swipe end
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! > 0) {
                // Swipe from left to right
                _handleSwipe();
              }
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    // Profile section below AppBar
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // Profile Avatar and Welcome Text
                      //     Row(
                      //       children: [
                      //         CircleAvatar(
                      //           radius: 20, // Profile icon size
                      //           backgroundColor: Color(0xFFD360C4),
                      //           child: Icon(
                      //             Icons.person,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //         SizedBox(width: 10),
                      //         Text(
                      //           "Welcome $name", // Replace with dynamic name
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             fontFamily: 'Outfit-Medium',
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     // Notification Icon in CircleAvatar
                      //     CircleAvatar(
                      //       radius: 16, // Match the size of the profile avatar
                      //       backgroundColor: Color(0xFFE747D2),
                      //       child: IconButton(
                      //         icon: Icon(
                      //           Icons.notifications,
                      //           color: Colors.white,
                      //           size: 17,
                      //         ),
                      //         onPressed: () {
                      //           // Add your notification logic here
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    // Main content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 80), // Prevent content overlap
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Search Bar
                              SizedBox(
                                height: 48,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    isDense: true, // Ensures compact layout
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              //Categories
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                          10), // Space below Category section
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis
                                          .horizontal, // Enables horizontal scrolling
                                      child: Row(
                                        children: [
                                          _buildCategoryWithLabel(
                                              'assets/item1.png', 'Category 1'),
                                          SizedBox(
                                              width:
                                                  16), // Space between categories
                                          _buildCategoryWithLabel(
                                              'assets/item2.png', 'Category 2'),
                                          SizedBox(width: 16),
                                          _buildCategoryWithLabel(
                                              'assets/Signup.png', 'Signup'),
                                          SizedBox(width: 16),
                                          _buildCategoryWithLabel(
                                              'assets/OTP.png', 'OTP'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              // Carousel
                              carousel_slider.CarouselSlider.builder(
                                options: carousel_slider.CarouselOptions(
                                  height: 200, // Height of the carousel
                                  autoPlay: true, // Enable auto play
                                  enlargeCenterPage:
                                      true, // Enlarge the center item
                                  viewportFraction:
                                      0.85, // Adjust visible portion
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _activeIndex =
                                          index; // Update active index for indicator
                                    });
                                  },
                                ),
                                itemCount: 3, // Number of carousel items
                                itemBuilder: (context, index, realIndex) {
                                  return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      child: SizedBox(
                                        width: 400, // Set the card width
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: AppTheme.secondaryColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Item ${index + 1}",
                                              style: TextStyle(
                                                fontFamily: 'Outfit-Regular',
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                              SizedBox(height: 16),
                              // SmoothPageIndicator
                              Align(
                                alignment: Alignment.center,
                                child: AnimatedSmoothIndicator(
                                  activeIndex: _activeIndex,
                                  count: 3, // Number of carousel items
                                  effect: ExpandingDotsEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    spacing: 8,
                                    expansionFactor: 3,
                                    dotColor: AppTheme.secondaryColor,
                                    activeDotColor: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),

                              // Filters
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     // Sort Button (Trigger Bottom Modal Sheet)
                              //     Container(
                              //       height: 40,
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color: textColor, // Border color
                              //           width: 1.0, // Border width
                              //         ),
                              //         borderRadius: BorderRadius.circular(
                              //             50), // Rounded corners
                              //         // Background color for the button
                              //       ),
                              //       child: TextButton(
                              //         onPressed: () {
                              //           // Show Bottom Modal Sheet for Sorting
                              //           showModalBottomSheet(
                              //             context: context,
                              //             builder: (BuildContext context) {
                              //               return Container(
                              //                 height: 350,
                              //                 padding: EdgeInsets.all(16),
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Text(
                              //                       "Sort By",
                              //                       style: TextStyle(
                              //                         fontSize: 20,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         color: textColor,
                              //                       ),
                              //                     ),
                              //                     ListTile(
                              //                       title: Text("All"),
                              //                       onTap: () {
                              //                         setState(() {
                              //                           selectedSortOption =
                              //                               'All';
                              //                         });
                              //                         Navigator.pop(context);
                              //                         sortItems();
                              //                       },
                              //                     ),
                              //                     ListTile(
                              //                       title: Text(
                              //                           "Price: Low to High"),
                              //                       onTap: () {
                              //                         setState(() {
                              //                           selectedSortOption =
                              //                               'Price: Low to High';
                              //                         });
                              //                         Navigator.pop(context);
                              //                         sortItems();
                              //                       },
                              //                     ),
                              //                     ListTile(
                              //                       title: Text(
                              //                           "Price: High to Low"),
                              //                       onTap: () {
                              //                         setState(() {
                              //                           selectedSortOption =
                              //                               'Price: High to Low';
                              //                         });
                              //                         Navigator.pop(context);
                              //                         sortItems();
                              //                       },
                              //                     ),
                              //                     ListTile(
                              //                       title: Text("Newest"),
                              //                       onTap: () {
                              //                         setState(() {
                              //                           selectedSortOption =
                              //                               'Newest';
                              //                         });
                              //                         Navigator.pop(context);
                              //                         sortItems();
                              //                       },
                              //                     ),
                              //                     ListTile(
                              //                       title: Text("Popularity"),
                              //                       onTap: () {
                              //                         setState(() {
                              //                           selectedSortOption =
                              //                               'Popularity';
                              //                         });
                              //                         Navigator.pop(context);
                              //                         sortItems();
                              //                       },
                              //                     ),
                              //                   ],
                              //                 ),
                              //               );
                              //             },
                              //           );
                              //         },
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             Icon(
                              //               FontAwesomeIcons
                              //                   .sliders, // Icon on the left
                              //               size: 17.0, // Customize size
                              //               color:
                              //                   textColor, // Customize color
                              //             ),
                              //             SizedBox(
                              //                 width:
                              //                     4), // Add some spacing between icon and text
                              //             Text(
                              //               selectedSortOption.isEmpty
                              //                   ? "Sort By"
                              //                   : selectedSortOption, // Show selected option or default text
                              //               style: TextStyle(
                              //                 fontFamily: 'Outfit-Regular',
                              //                 color: textColor
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // Filter Button with the same theme as Sort
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(
                              //             15), // Rounded corners
                              //         color: Color(
                              //             0xFFF8E1F4), // Background color for the button
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.black.withOpacity(
                              //                 0.2), // Shadow effect
                              //             blurRadius: 6, // Subtle blur effect
                              //             offset:
                              //                 Offset(2, 2), // Shadow position
                              //           ),
                              //         ],
                              //       ),
                              //       child: TextButton(
                              //         onPressed: () {
                              //           // Implement filter logic here
                              //         },
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             Icon(
                              //               FontAwesomeIcons
                              //                   .filter, // Filter icon
                              //               size: 17.0, // Customize size
                              //               color:
                              //                   Colors.black, // Customize color
                              //             ),
                              //             SizedBox(
                              //                 width:
                              //                     4), // Add some spacing between icon and text
                              //             Text(
                              //               "Filter", // Text for the button
                              //               style: TextStyle(
                              //                 fontFamily: 'Outfit-Regular',
                              //                 color: Colors.black,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              
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
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate to the details page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(16),
                                                    topLeft:
                                                        Radius.circular(16)),
                                                color: Colors.grey[300],
                                              ),

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
                                                  style: TextStyle(fontFamily: 'Outfit-Regular',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text("₹1300",
                                                        style: TextStyle(fontFamily: 'Outfit-Regular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "₹1500",
                                                      style: TextStyle(fontFamily: 'Outfit-Regular',
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.pink,
                                                        size: 16),
                                                    SizedBox(width: 4),
                                                    Text("4.0",style: TextStyle(fontFamily: 'Outfit-Reglar'),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
                  height: 70,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkBackgroundColor
                          : AppTheme
                              .lightBackgroundColor, // Dynamic background color
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black45 // Darker shadow for dark theme
                              : Colors
                                  .black26, // Lighter shadow for light theme
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
                          _buildNavBarItem(
                            Icons.home,
                            "Home",
                            AppTheme.primaryColor,
                            () {}, // Handle navigation
                          ),
                          _buildNavBarItem(
                            Icons.shopping_bag,
                            "Orders",
                            Colors.grey,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsPage()),
                              );
                            },
                          ),
                          _buildNavBarItem(
                            Icons.shopping_bag,
                            "Orders",
                            Colors.grey,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsPage()),
                              );
                            },
                          ),
                          _buildNavBarItem(
                            Icons.grid_view,
                            "Categories",
                            Colors.grey,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryPage()),
                              );
                            },
                          ),
                          _buildNavBarItem(
                            Icons.person,
                            "Account",
                            Colors.grey,
                            _navigateToProfile,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryWithLabel(String imagePath, String label) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return Column(
      children: [
        _buildCategoryCircle(),
        SizedBox(height: 8), // Space between the circle and the label
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Outfit-Regular',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCategoryCircle() {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor, // Light pink background shade
        shape: BoxShape.circle, // Makes the container circular
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Padding inside the circle
        
      ),
    );
  }

  Widget _buildNavBarItem(
      IconData icon, String label, Color color, VoidCallback onTap) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return GestureDetector(
      onTap: onTap, // Trigger the navigation or other action on tap
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(fontFamily: 'Outfit-Regular', color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

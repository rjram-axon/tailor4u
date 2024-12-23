import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tailor4u/screens/cart.dart';
import 'package:tailor4u/sections/app_theme.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentIndex = 0; // Tracks the current image index
  int _colorIndex = 0; // Tracks the active color option index
  bool _isItemInCart = false;
  bool _isButtonPressed = false;
  int _cartItemCount = 0;
  String? _selectedSize; // Add this variable

  final List<String> _imagePaths = [
    'assets/item1.png',
    'assets/item2.png',
    'assets/Login.png',
    'assets/OTP.png',
  ];

  void _toggleCartStatus() {
    setState(() {
      _isItemInCart = !_isItemInCart;
      _isButtonPressed = true;
      if (_cartItemCount > 0) {
        _cartItemCount = 0; // Remove from cart
      } else {
        _cartItemCount =
            1; // Add item to cart, set count to 1 (or increase based on your logic)
      }
    });

    // Ensure the Flushbar is shown properly and doesn't conflict with rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        message:
            _isItemInCart ? "Item added to cart!" : "Item removed from cart!",
        backgroundColor: _isItemInCart ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
        flushbarPosition:
            FlushbarPosition.TOP, // Position the flushbar at the top
        icon: Icon(
          _isItemInCart ? Icons.check_circle : Icons.remove_circle,
          color: Colors.white,
          size: 28, // Increased icon size
        ),
        margin:
            EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Add margin
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Soft shadow
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
        animationDuration: Duration(milliseconds: 500), // Smooth animation
        forwardAnimationCurve: Curves.easeInOut, // Smooth entry
        reverseAnimationCurve: Curves.easeOut, // Smooth exit
        isDismissible: true, // Allow dismissing
      )..show(context);
    });

    // Reset button pressed state after delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Check if the widget is still mounted before updating state
        setState(() {
          _isButtonPressed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            // CustomScrollView to handle the content scrolling
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    // Product Image Section
                    CarouselSlider.builder(
                      itemCount: _imagePaths.length,
                      options: CarouselOptions(
                        height: 350,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                            _colorIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            _imagePaths[index],
                            height: 250,
                            width: 400,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    // Dot Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _imagePaths.asMap().entries.map((entry) {
                        bool isActive = _currentIndex == entry.key;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isActive ? 16.0 : 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: Colors.pink.shade100,
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                    )
                                  ]
                                : [],
                            gradient: LinearGradient(
                              colors: isActive
                                  ? [
                                      AppTheme.primaryColor,
                                      AppTheme.secondaryColor
                                    ]
                                  : [
                                      Colors.grey.shade300,
                                      Colors.grey.shade300
                                    ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    // Color Selection and Size Options
                    _sectionTitle("Color: Yellow"),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imagePaths.length,
                        itemBuilder: (context, index) {
                          return _colorOption(_imagePaths[index], index);
                        },
                      ),
                    ),
                    // Size Heading and Size Chart Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _sectionTitle("Size:"),
                        TextButton(
                          onPressed: () {
                            // Show size chart modal or navigate to size chart page
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.secondaryColor,
                            textStyle: TextStyle(
                                fontFamily: 'Outfit-Regular',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          child: Text("Size Chart"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _sizeOption("S"),
                          _sizeOption("M"),
                          _sizeOption("L"),
                          _sizeOption("XL"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Customize Fit Button (conditionally displayed)
                    if (_selectedSize != null) ...[
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            backgroundColor: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            // Handle Customize Fit action here
                          },
                          child: Text(
                            "Customize Fit",
                            style: const TextStyle(
                                fontFamily: 'Outfit-Regular',
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                    // Price and Add to Cart Section

                    const SizedBox(height: 16),
                    // Delivery and Care Details
                    _sectionTitle("Delivery & Details"),
                    _infoRow(Icons.local_shipping,
                        "Expected Delivery within 4-6 days"),
                    _infoRow(Icons.money, "Cash on Delivery Available"),
                    const SizedBox(height: 16),
                    _sectionTitle("Details & Care"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailsText("Round Neck"),
                          _detailsText("Cotton"),
                          _detailsText("Hand wash"),
                          _detailsText("100% Cotton"),
                          _detailsText("Model Size M"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80), // Ensure space for the button
                  ]),
                ),
              ],
            ),
            // Back Button on the top-left
            Positioned(
              top: 2,
              left: 10,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            // Shopping Bag Icon with Item Count
            Positioned(
              top: 2,
              right: 10,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartPage()), // Replace with your CartPage widget
                        );
                      },
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                    if (_cartItemCount >
                        0) // Show badge if there are items in the cart
                      Positioned(
                        right: 0,
                        top: -8,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              '$_cartItemCount', // Display the count
                              style: TextStyle(
                                fontFamily: 'Outfit-Regular',
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Add to Cart Button at the Bottom with Animation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      backgroundColor, // Background color for the bottom section
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                              .withOpacity(0.4) // Dark shadow for dark theme
                          : Colors.grey.shade300
                              .withOpacity(0.7), // Light shadow for light theme
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distribute space between price and button
                  children: [
                    // Price Section (Left side)
                    Row(
                      children: [
                        // Original Price (strikethrough for discount)
                        Text(
                          "\$39.99", // Original Price
                          style: TextStyle(
                            fontFamily: 'Outfit-Regular',
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration
                                .lineThrough, // Strikethrough effect
                          ),
                        ),
                        const SizedBox(
                            width:
                                8), // Space between original and discounted price
                        // Discounted Price
                        Text(
                          "\$29.99", // Discounted Price
                          style: TextStyle(
                            fontFamily: 'Outfit-Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.red.shade700, // Discounted price in red
                          ),
                        ),
                      ],
                    ),
                    // Add to Cart Button (Right side)
                    AnimatedScale(
                      scale:
                          _isButtonPressed ? 1.1 : 1.0, // Scale up when pressed
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          backgroundColor: AppTheme.primaryColor,
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                          disabledBackgroundColor:
                              Colors.grey.withOpacity(0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                              .withOpacity(0.4) // Dark shadow for dark theme
                          : Colors.grey.shade300
                              .withOpacity(0.7), 
                          elevation: 10, // For the disabled state
                        ),
                        onPressed: () {
                          if (_isItemInCart) {
                            // If item is in cart, navigate to the Cart Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CartPage()), // Replace with your CartPage widget
                            );
                          } else {
                            // Otherwise, toggle cart status (add to cart)
                            _toggleCartStatus();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _isItemInCart
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 24,
                                      key: ValueKey<int>(
                                          1), // Unique key for animation
                                    )
                                  : Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 24,
                                      key: ValueKey<int>(
                                          0), // Unique key for animation
                                    ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isItemInCart ? "Go to Cart" : "Add to Cart",
                              style: const TextStyle(
                                fontFamily: 'Outfit-Regular',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sizeOption(String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedSize = size; // Update selected size
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          backgroundColor: _selectedSize == size
              ? AppTheme.primaryColor
              : Colors.transparent, // Highlight selected size
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: Color(0xFF49225B),
              width: 2,
            ),
          ),
          elevation: 0,
        ),
        child: Text(
          size,
          style: TextStyle(
            fontFamily: 'Outfit-Regular',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _selectedSize == size
                ? Colors.white
                : Color(0xFF49225B), // Match text color with background
          ),
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String title) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'Outfit-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor),
      ),
    );
  }

  // Color Option Widget
  Widget _colorOption(String assetPath, int index) {
    bool isActive = _colorIndex == index; // Check if this is the active image

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _colorIndex = index; // Update active color index on tap
          });
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
              width: isActive ? 3 : 1, // Thicker border if active
            ),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(assetPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // Info Row Widget (Delivery, Care)
  Widget _infoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink.shade300),
          const SizedBox(width: 8),
          Text(info,
              style:
                  const TextStyle(fontFamily: 'Outfit-Regular', fontSize: 16)),
        ],
      ),
    );
  }

  // Details Text Widget
  Widget _detailsText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(text,
          style: const TextStyle(fontFamily: 'Outfit-Regular', fontSize: 16)),
    );
  }
}

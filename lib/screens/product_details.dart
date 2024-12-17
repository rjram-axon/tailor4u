import 'package:flutter/material.dart';



class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        title: const Text(
          "BLOUSE CRAFT",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Back Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Image
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/blouse_image.png', // Replace with your asset image
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 4, backgroundColor: Colors.pink),
                      SizedBox(width: 4),
                      CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                      SizedBox(width: 4),
                      CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),

            // Color Selection
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Color: Yellow",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  colorOption('assets/blouse_thumb1.png'),
                  colorOption('assets/blouse_thumb2.png'),
                  colorOption('assets/blouse_thumb3.png'),
                  colorOption('assets/blouse_thumb4.png'),
                ],
              ),
            ),

            // Size Options
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Size",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Size chart",
                            style: TextStyle(color: Colors.pink)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['XS', 'S', 'M', 'L', 'XL', 'XXL']
                        .map((size) => Chip(
                              label: Text(size),
                              backgroundColor: Colors.pink.shade50,
                              side: BorderSide(color: Colors.pink.shade300),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),

            // Delivery & Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_shipping, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text("Expected Delivery within 4-6 days"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.money, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text("Cash on Delivery Available"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Details & Care",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  detailsText("Round Neck"),
                  detailsText("Cotton"),
                  detailsText("Hand wash"),
                  detailsText("100% Cotton"),
                  detailsText("Model Size M"),
                ],
              ),
            ),

            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for color thumbnails
  static Widget colorOption(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink.shade300, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }

  // Widget for product details
  static Widget detailsText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        "- $text",
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Sample list of stitchable women's clothing categories with corresponding images
  List<Map<String, String>> categories = [
    {"name": "Dresses", "image": "assets/item1.png"},
    {"name": "Tops & Blouses", "image": "assets/item2.png"},
    {"name": "Skirts & Pants", "image": "assets/OTP.png"},
    {"name": "Kurtis & Tunics", "image": "assets/Signup.png"},
    {"name": "Sarees", "image": "assets/OTP.png"},
    {"name": "Lehengas", "image": "assets/Signup.png"},
  ];

  // Sample function to navigate to category details (can be expanded)
  void navigateToCategory(String category) {
    // For now, we'll just show a simple dialog when a category is tapped.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Category Details"),
          content: Text("Details for the category: $category"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories",style: TextStyle(color: Colors.white, fontFamily: 'Outfit-Regular')),
        backgroundColor: Color(0xFFBE359C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 16),
            // Category List in GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 16.0, // Space between cards horizontally
                  mainAxisSpacing: 16.0, // Space between cards vertically
                  childAspectRatio:
                      0.75, // Aspect ratio of the card (width/height)
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () =>
                          navigateToCategory(categories[index]["name"]!),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              categories[index]["image"]!,
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              categories[index]["name"]!,
                              style: TextStyle(
                                fontFamily: 'Outfit-Regular',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

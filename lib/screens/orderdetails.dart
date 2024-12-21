import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderItems = [
    {
      "item": "Item 1",
      "price": 25.00,
      "quantity": 2,
      "discount": 5.00,
      "image": 'assets/OTP.png',
      "priceBreakup": {"price": 25.00, "discount": 5.00, "total": 45.00},
      "orderStatus": "Shipped",  // Added Order Status
      "paymentStatus": "Paid",   // Added Payment Status
    },
    {
      "item": "Item 2",
      "price": 50.00,
      "quantity": 1,
      "discount": 10.00,
      "image": 'assets/item1.png',
      "priceBreakup": {"price": 50.00, "discount": 10.00, "total": 40.00},
      "orderStatus": "Pending",
      "paymentStatus": "Pending",
    },
    {
      "item": "Item 3",
      "price": 10.00,
      "quantity": 3,
      "discount": 2.00,
      "image": 'assets/item2.png',
      "priceBreakup": {"price": 10.00, "discount": 2.00, "total": 24.00},
      "orderStatus": "Delivered",
      "paymentStatus": "Paid",
    },
  ];

  // Delivery address and contact details
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details" ,style: TextStyle(color: Colors.white, fontFamily: 'Outfit-Regular')),
        backgroundColor: Color(0xFFBE359C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  var item = orderItems[index];
                  // Calculate discount percentage
                  double discountPercentage = (item['discount'] / item['price']) * 100;

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Image of the item
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image'], // Ensure this key is correct in your data
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),

                          // Column to display item details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['item'], // Item name
                                  style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Price: \$${item['price'].toStringAsFixed(2)}",
                                  style: TextStyle(fontFamily: 'Outfit-Regular', fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Discount: ${discountPercentage.toStringAsFixed(2)}%",
                                  style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14),
                                ),
                                SizedBox(height: 8),
                                // Display Order Status and Payment Status
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Status: ${item['orderStatus']}",
                                      style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14, color: Colors.green),
                                    ),
                                    Text(
                                      "Payment Status: ${item['paymentStatus']}",
                                      style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14, color: Colors.blue),
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method to display price details
  Widget _buildPriceDetails(Map<String, dynamic> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Price: \$${item['price'].toStringAsFixed(2)}",
            style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14)),
        Text("Qty: ${item['quantity']}", style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14)),
        Text(
            "Total: \$${(item['quantity'] * item['price']).toStringAsFixed(2)}",
            style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14)),
      ],
    );
  }

  // Helper Method to display discount details
  Widget _buildDiscountDetails(Map<String, dynamic> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Discount: \$${item['discount'].toStringAsFixed(2)}",
            style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14)),
        Text(
            "Price after Discount: \$${item['priceBreakup']['total'].toStringAsFixed(2)}",
            style: TextStyle(fontFamily: 'Outfit-Regular',fontSize: 14)),
      ],
    );
  }
}

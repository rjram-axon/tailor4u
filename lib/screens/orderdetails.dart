import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  // Sample data for order details
  String orderNumber = "ORD123456";
  String orderDate = "December 20, 2024";
  String orderStatus = "Pending";
  double totalAmount = 150.75;

  List<Map<String, dynamic>> orderItems = [
    {"item": "Item 1", "quantity": 2, "price": 25.00},
    {"item": "Item 2", "quantity": 1, "price": 50.00},
    {"item": "Item 3", "quantity": 3, "price": 10.00},
  ];

  // Sample function for handling actions like Approve/Revert
  void handleAction(String action) {
    if (action == "Approve") {
      setState(() {
        orderStatus = "Approved";
      });
    } else if (action == "Revert") {
      setState(() {
        orderStatus = "Pending";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Information
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Number: $orderNumber", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Order Date: $orderDate", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 8),
                    Text("Order Status: $orderStatus", style: TextStyle(fontSize: 14, color: orderStatus == "Pending" ? Colors.orange : Colors.green)),
                    SizedBox(height: 8),
                    Text("Total Amount: \$${totalAmount.toStringAsFixed(2)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Order Items List
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(orderItems[index]['item'], style: TextStyle(fontSize: 16)),
                          Text("Qty: ${orderItems[index]['quantity']}", style: TextStyle(fontSize: 14)),
                          Text("\$${(orderItems[index]['quantity'] * orderItems[index]['price']).toStringAsFixed(2)}", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => handleAction("Approve"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Approve", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => handleAction("Revert"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Revert", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

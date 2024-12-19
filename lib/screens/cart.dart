import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items
  List<CartItem> cartItems = [
    CartItem(name: 'Product 1', price: 29.99),
    CartItem(name: 'Product 2', price: 19.99),
    CartItem(name: 'Product 3', price: 39.99),
  ];

  // Calculate the total price
  double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }

  // Remove item from the cart
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Colors.pink,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.shopping_cart, color: Colors.pink),
                    title: Text(cartItems[index].name),
                    subtitle: Text('\$${cartItems[index].price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeItem(index),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.pink.shade50,
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout functionality
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Checkout'),
                      content: Text('Proceed to checkout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Handle checkout logic here
                          },
                          child: Text('Proceed'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Checkout'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}

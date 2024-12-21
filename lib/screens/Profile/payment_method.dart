import 'package:flutter/material.dart';

class PaymentOptionsPage extends StatefulWidget {
  @override
  _PaymentOptionsPageState createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  // List of payment methods
  List<Map<String, dynamic>> paymentMethods = [
    {"name": "Credit/Debit Card", "icon": Icons.credit_card},
    {"name": "PayPal", "icon": Icons.account_balance_wallet},
    {"name": "Google Pay", "icon": Icons.payment},
    {"name": "Cash on Delivery", "icon": Icons.money},
  ];

  // Function to show confirmation after selecting a payment method
  void showPaymentConfirmation(String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Payment Confirmation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFBE359C),
            ),
          ),
          content: Text("You have selected: $paymentMethod"),
          actions: [
            TextButton(
              onPressed: () {
                // Go back to the previous page
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
              child: Text(
                "Go Back",
                style: TextStyle(color: Color(0xFFBE359C)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Color(0xFFBE359C)),
              ),
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
        title: Text(
          "Payment Options",
          style: TextStyle(color: Colors.white, fontFamily: 'Outfit-Regular'),
        ),
        backgroundColor: Color(0xFFBE359C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white, // Set solid white background color
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(height: 20),
              // Payment Method List
              Expanded(
                child: ListView.builder(
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => showPaymentConfirmation(paymentMethods[index]["name"]),
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.grey[200], // Set light grey color for cards
                        shadowColor: Colors.black.withOpacity(0.1),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          leading: Icon(
                            paymentMethods[index]["icon"],
                            size: 32,
                            color: Color(0xFFBE359C),
                          ),
                          title: Text(
                            paymentMethods[index]["name"],
                            style: TextStyle(
                              fontFamily: 'Outfit-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFBE359C),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

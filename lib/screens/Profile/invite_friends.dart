import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteFriendsPage extends StatelessWidget {
  final String referralCode = "XYZ123"; // Example referral code, you can generate it dynamically.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Text(
              "Invite Your Friends and Earn Rewards!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 20),

            // Referral Description
            Text(
              "Share your referral code with your friends and get exciting rewards when they sign up. The more friends you invite, the more rewards you can earn!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Referral Code Section
            Text(
              "Your Referral Code:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    referralCode,
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      // Copy referral code to clipboard
                      Clipboard.setData(ClipboardData(text: referralCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Referral code copied to clipboard!")),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Share Options Section
            Text(
              "Share with Friends:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Share via WhatsApp
                IconButton(
                  icon: Icon(Icons.chat_bubble, color: Colors.green, size: 32),
                  onPressed: () {
                    // Implement WhatsApp share functionality
                    // You can use packages like `flutter_share` or `share_plus` for actual sharing functionality
                  },
                ),
                // Share via Facebook
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.blue, size: 32),
                  onPressed: () {
                    // Implement Facebook share functionality
                  },
                ),
                // Share via Email
                IconButton(
                  icon: Icon(Icons.email, color: Colors.red, size: 32),
                  onPressed: () {
                    // Implement Email share functionality
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Referral Program Info
            Text(
              "How It Works:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. Share your referral code with your friends.\n"
              "2. When they sign up using your code, they get a discount.\n"
              "3. You earn rewards once they make their first purchase or complete an action.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Call to Action Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // You can add further functionality here (e.g., redirect to a referral landing page)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invite friends and start earning rewards!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text("Invite Friends Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

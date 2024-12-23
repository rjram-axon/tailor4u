import 'package:flutter/material.dart';
import 'package:tailor4u/sections/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Privacy Policy Title
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 20),

            // Introduction Section
            Text(
              "At [Your Company Name], we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our services.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Data Collection Section
            Text(
              "1. Data Collection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We collect personal information that you provide to us directly, such as your name, email address, and payment details. We may also collect information automatically, such as usage data and device information, to improve our services.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Data Usage Section
            Text(
              "2. Data Usage",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We use the information we collect to provide, improve, and personalize our services. This may include processing payments, responding to customer support inquiries, and sending notifications about your account or services.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Data Protection Section
            Text(
              "3. Data Protection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We implement security measures to protect your personal information. However, no method of data transmission or storage is 100% secure, and we cannot guarantee the absolute security of your data.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Third-Party Sharing Section
            Text(
              "4. Sharing Your Data",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We do not sell or rent your personal information to third parties. We may share your information with trusted service providers who assist us in operating our business and providing services to you. These third parties are obligated to keep your information confidential.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Cookies Section
            Text(
              "5. Cookies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We use cookies and similar technologies to enhance your experience on our website and app. Cookies help us analyze website traffic and customize content. You can manage your cookie preferences through your browser settings.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // User Rights Section
            Text(
              "6. Your Rights",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "You have the right to access, update, or delete your personal information. If you wish to exercise these rights, please contact us using the details provided below.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Contact Information Section
            Text(
              "7. Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "If you have any questions or concerns about our privacy practices, please contact us at:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Email: support@example.com",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Phone: +123 456 7890",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Conclusion Section
            Text(
              "By using our services, you consent to the collection and use of your information as described in this Privacy Policy.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

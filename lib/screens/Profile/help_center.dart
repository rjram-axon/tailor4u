import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // FAQs Section
            SectionTitle(title: "Frequently Asked Questions"),
            ListTile(
              title: Text("How do I reset my password?"),
              onTap: () {
                // Navigate to a page with detailed FAQ or expand for details
              },
            ),
            ListTile(
              title: Text("How do I track my order?"),
              onTap: () {
                // Navigate to a page with detailed FAQ or expand for details
              },
            ),
            ListTile(
              title: Text("What payment methods do you accept?"),
              onTap: () {
                // Navigate to a page with detailed FAQ or expand for details
              },
            ),
            Divider(),

            // Contact Us Section
            SectionTitle(title: "Contact Us"),
            ListTile(
              title: Text("Email Us"),
              subtitle: Text("support@example.com"),
              onTap: () {
                // Launch email client or show email form
              },
            ),
            ListTile(
              title: Text("Call Us"),
              subtitle: Text("+123 456 7890"),
              onTap: () {
                // Dial phone number
              },
            ),
            Divider(),

            // Submit a Ticket Section
            SectionTitle(title: "Submit a Support Ticket"),
            ListTile(
              title: Text("Submit a ticket for further assistance"),
              onTap: () {
                // Navigate to a support form page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportFormPage()),
                );
              },
            ),
            Divider(),

            // Additional Resources Section
            SectionTitle(title: "Additional Resources"),
            ListTile(
              title: Text("User Manual"),
              onTap: () {
                // Navigate to a user manual page or PDF
              },
            ),
            ListTile(
              title: Text("Video Tutorials"),
              onTap: () {
                // Navigate to a page with video tutorials
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}

class SupportFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit a Ticket"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Please fill out the form below to submit a support ticket.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Email Address",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Issue Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Ticket submitted successfully")),
                );
              },
              child: Text("Submit Ticket"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

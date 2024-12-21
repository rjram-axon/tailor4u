import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkThemeEnabled = false;

  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  void toggleTheme(bool value) {
    setState(() {
      darkThemeEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkThemeEnabled = Provider.of<ThemeNotifier>(context).isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFBE359C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Notifications Setting with customized switch
            ListTile(
              title: Text("Notifications"),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: toggleNotifications,
                activeColor: Color(0xFFBE359C),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[400],
                activeTrackColor: Color(0xFFBE359C).withOpacity(0.3),
              ),
            ),
            Divider(),

            // Dark Theme Setting with customized switch
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                value: darkThemeEnabled,
                onChanged: (value) {
                  // When the switch is toggled, update the theme
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme();
                },
                activeColor: Color(0xFFBE359C),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[400],
                activeTrackColor: Color(0xFFBE359C).withOpacity(0.3),
              ),
            ),
            Divider(),

            // Change Password Section
            ListTile(
              title: Text("Change Password"),
              leading: Icon(Icons.lock, color: Color(0xFFBE359C)),
              onTap: () {
                // Navigate to change password page
              },
            ),
            Divider(),

            // Log Out Section
            ListTile(
              title: Text("Send Feedback"),
              leading: Icon(Icons.feedback, color: Color(0xFFBE359C)),
              onTap: () {
                // Navigate to a feedback form or open email client
                // Example: open email client with a pre-filled feedback subject
              },
            ),

            Divider(),

            // App Version Information
            ListTile(
              title: Text("App Version"),
              subtitle: Text("1.0.0"), // Dynamically fetched version
              leading: Icon(Icons.info, color: Color(0xFFBE359C)),
              onTap: () {
                // Optionally navigate to version details page
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme;

  // Constructor to set the initial theme based on system settings
  ThemeNotifier(this._isDarkTheme);

  bool get isDarkTheme => _isDarkTheme;

  // Method to toggle the theme
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}

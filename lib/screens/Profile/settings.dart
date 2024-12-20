import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Track whether the user has enabled notifications
  bool notificationsEnabled = true;

  // Track whether dark theme is enabled
  bool darkThemeEnabled = false;

  // Track selected language
  String selectedLanguage = 'English';

  // Function to change the theme
  void toggleTheme(bool value) {
    setState(() {
      darkThemeEnabled = value;
    });
  }

  // Function to change the language
  void changeLanguage(String value) {
    setState(() {
      selectedLanguage = value;
    });
  }

  // Function to toggle notifications
  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Notifications Setting
            ListTile(
              title: Text("Notifications"),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: toggleNotifications,
              ),
            ),
            Divider(),

            // Theme Setting
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                value: darkThemeEnabled,
                onChanged: toggleTheme,
              ),
            ),
            Divider(),

            // Language Setting
            ListTile(
              title: Text("Language"),
              subtitle: Text(selectedLanguage),
              onTap: () {
                // Show a simple dialog to choose a language
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Choose Language"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text("English"),
                            onTap: () {
                              changeLanguage("English");
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text("Spanish"),
                            onTap: () {
                              changeLanguage("Spanish");
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text("French"),
                            onTap: () {
                              changeLanguage("French");
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Divider(),

            // Account Settings Section
            ListTile(
              title: Text("Account Settings"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to account settings page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsPage()));
              },
            ),
            Divider(),

            // About Section
            ListTile(
              title: Text("About"),
              trailing: Icon(Icons.info_outline),
              onTap: () {
                // Navigate to about page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

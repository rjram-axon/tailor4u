import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/sections/app_theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedTheme = 'System Default'; // Default value (non-nullable)

  @override
  void initState() {
    super.initState();
    // Initialize the theme by fetching from ThemeNotifier or SharedPreferences
    _loadTheme();
  }

  // Load theme from the ThemeNotifier
  void _loadTheme() async {
    String currentTheme = await ThemeNotifier.loadThemePreference();
    setState(() {
      selectedTheme = currentTheme;
    });
  }

  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;

    String currentTheme = Provider.of<ThemeNotifier>(context).currentTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFBE359C),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 5, // Subtle elevation for depth
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Notifications Setting with customized switch
            _buildListTile(
              title: "Notifications",
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: toggleNotifications,
                activeColor: Color(0xFFBE359C),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[400],
                activeTrackColor: Color(0xFFBE359C).withOpacity(0.3),
              ),
            ),

            // Theme Setting with Dropdown to select light, dark, or system default
            _buildListTile(
              title: "Theme",
              trailing: DropdownButton<String>(
                value: selectedTheme,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    // Ensure the value is non-null
                    setState(() {
                      selectedTheme = newValue;
                    });
                    // Update the theme based on the selected option
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .setTheme(newValue);
                  }
                },
                items: <String>['Light', 'Dark', 'System Default']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Send Feedback Section
            _buildListTile(
              title: "Send Feedback",
              leadingIcon: Icons.feedback,
              onTap: () {
                // Navigate to feedback form or open email client
              },
            ),

            // App Version Information
            _buildListTile(
              title: "App Version",
              subtitle: "1.0.0", // Dynamically fetched version
              leadingIcon: Icons.info,
              onTap: () {
                // Optionally navigate to version details page
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a ListTile with optional leading and trailing widgets
  Widget _buildListTile(
      {required String title,
      Widget? trailing,
      String? subtitle,
      IconData? leadingIcon,
      Function()? onTap}) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return Card(
      elevation: 5, // Adding elevation to give depth
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              )
            : null,
        leading: leadingIcon != null
            ? Icon(leadingIcon, color: Color(0xFFBE359C))
            : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  // Divider with a custom color and thickness
}

class ThemeNotifier extends ChangeNotifier with WidgetsBindingObserver {
  String _currentTheme;

  ThemeNotifier(this._currentTheme) {
    // Add the observer to listen to changes
    WidgetsBinding.instance.addObserver(this);
    _initializeTheme();
  }

  String get currentTheme => _currentTheme;

  // Initialize theme based on system settings or user preference
  void _initializeTheme() {
    if (_currentTheme == 'System Default') {
      _currentTheme =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark
              ? 'Dark'
              : 'Light';
    }
    notifyListeners();
  }

  // Method to set the theme based on user selection
  void setTheme(String theme) {
    _currentTheme = theme;
    _saveThemePreference(theme); // Save the selected theme
    notifyListeners();
  }

  // Method to apply the theme to the app
  ThemeData get themeData {
    switch (_currentTheme) {
      case 'Light':
        return ThemeData.light();
      case 'Dark':
        return ThemeData.dark();
      case 'System Default':
      default:
        // Use the system theme based on the platform's brightness
        return WidgetsBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? ThemeData.dark()
            : ThemeData.light();
    }
  }

  // Save the theme to SharedPreferences
  Future<void> _saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }

  // Load the theme from SharedPreferences
  static Future<String> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme') ??
        'System Default'; // Default to system theme if not set
  }

  // When the system theme changes, we need to update the theme accordingly
  @override
  void didChangePlatformBrightness() {
    if (_currentTheme == 'System Default') {
      _currentTheme =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark
              ? 'Dark'
              : 'Light';
      notifyListeners(); // Notify listeners when the theme changes
    }
  }

  // Clean up the observer when not needed
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

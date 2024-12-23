import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/authentication/profile_service.dart';
import 'package:tailor4u/screens/Profile/edit_profile.dart';
import 'package:tailor4u/screens/Profile/help_center.dart';
import 'package:tailor4u/screens/Profile/invite_friends.dart';
import 'package:tailor4u/screens/Profile/payment_method.dart';
import 'package:tailor4u/screens/Profile/privacy_policy.dart';
import 'package:tailor4u/screens/Profile/saved.address.dart';
import 'package:tailor4u/screens/Profile/settings.dart';
import 'package:tailor4u/screens/login_screen.dart';
import 'package:tailor4u/sections/app_theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profilePic = 'assets/item1.png'; // Default image
  String name = '';
  ProfileService profileService = ProfileService();
  

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final profileService = ProfileService();
    await profileService.loadFromLocalStorage(); // Load from local storage
    setState(() {
      name = profileService.name; // Use data from local storage
      profilePic = profileService.profilePic;
    });
  }
  // Load profile data on page initialization

  void _navigateToeditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }

  void _navigateToSavedAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedAddressPage()),
    );
  }

  void _navigateTo(String route) {
    // Navigation logic based on route
    print('Navigating to $route');

    if (route == 'logout') {
      // Clear any session or user data if needed

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MobileVerify()), // Navigate to the Login screen
      );
    }
    if (route == 'payment_method') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PaymentOptionsPage()), // Navigate to the Login screen
      );
    }
    if (route == 'settings') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SettingsPage()), // Navigate to the Login screen
      );
    }
    if (route == 'help_center') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HelpCenterPage()), // Navigate to the Login screen
      );
    }
    if (route == 'privacy_policy') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PrivacyPolicyPage()), // Navigate to the Login screen
      );
    }
    if (route == 'invite_friends') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InviteFriendsPage()), // Navigate to the Login screen
      );
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
              // await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MobileVerify()), // Navigate to the Login screen
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _changeProfilePic() {
    // Logic for changing profile picture (camera, gallery, etc.)
    setState(() {
      profilePic = 'assets/item1.png'; // Example of updating profile pic
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor.withOpacity(0.5),
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Container(
        color: AppTheme.primaryColor.withOpacity(0.5),
        child: Column(
          children: [
            // Profile Picture and Name Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(profilePic),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _changeProfilePic,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFFFFD8F9),
                            child:
                                Icon(Icons.edit, size: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    name, // Use the fetched name
                    style: TextStyle(color: backgroundColor, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Menu Options Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: _navigateToeditProfile,
                    ),
                    _buildMenuItem(
                      icon: Icons.payment,
                      title: 'Payment Method',
                      onTap: () => _navigateTo('payment_method'),
                    ),
                    _buildMenuItem(
                      icon: Icons.location_on,
                      title: 'Saved Address',
                      onTap: _navigateToSavedAddress,
                    ),
                    _buildMenuItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () => _navigateTo('settings'),
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      onTap: () => _navigateTo('help_center'),
                    ),
                    _buildMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () => _navigateTo('privacy_policy'),
                    ),
                    _buildMenuItem(
                      icon: Icons.group_add,
                      title: 'Invite Your Friends',
                      onTap: () => _navigateTo('invite_friends'),
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () => _showLogoutConfirmationDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
        bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme
        ? AppTheme.darkBackgroundColor
        : AppTheme.lightBackgroundColor;
    Color textColor =
        isDarkTheme ? AppTheme.darkTextColor : AppTheme.lightTextColor;
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
      onTap: onTap,
    );
  }
}

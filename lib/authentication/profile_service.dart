import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/screens/otp_screen.dart';

class ProfileService {
  // Singleton instance for global access
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;

  ProfileService._internal();

  // Global properties for name and profilePic
  String name = '';
  String profilePic = 'assets/item1.png'; // Default profile picture

  // Fetch the processed mobile number
  Future<String?> getProcessedMobileNumber() async {
    String? mobNum = await UserService().getUserMobile();

    if (mobNum != null && mobNum.startsWith('+91')) {
      mobNum = mobNum.substring(3); // Remove the country code
    }

    return mobNum;
  }

  // Fetch the profile data and store it globally
  Future<void> fetchProfileData(String mobNum) async {
    try {
      final response = await http.get(
        Uri.parse('https://sxzhq34r-3000.inc1.devtunnels.ms/api/users/get-user?phone_number=$mobNum'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map && data.containsKey('user')) {
          final user = data['user'];

          if (user is Map) {
            // Store user details globally
            name = user['name'] ?? 'Unknown Name';
            profilePic = user['profile_pic'] ?? 'assets/item1.png';

            print('Global Name: $name');
            print('Global Profile Picture: $profilePic');
          } else {
            throw Exception('Invalid user data format');
          }
        } else {
          throw Exception('User key not found in response');
        }
      } else {
        throw Exception('Failed to load profile data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      name = 'Error loading name';
      profilePic = 'assets/item1.png'; // Default profile picture
    }
  }
  // Save the name and profilePic to local storage
  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('profilePic', profilePic);
  }

  // Load the name and profilePic from local storage
  Future<void> loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? 'Unknown Name';
    profilePic = prefs.getString('profilePic') ?? 'assets/item1.png';
  }
}

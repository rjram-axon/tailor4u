import 'package:flutter/material.dart';
import 'package:tailor4u/authentication/profile_service.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String profilePic = 'assets/item1.png'; // Default image
  String name = '';
  String mobNum = '';
  String email = '';
  bool isEditingMobile = false;
  bool isEditingEmail = false;

  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final profileService = ProfileService();
    await profileService.loadFromLocalStorage(); // Load from local storage
    if (mounted) {
      setState(() {
        name = profileService.name; // Use data from local storage
        mobNum = profileService.mobNum;
        email = profileService.email;
      });
    }
  }

  void _changeProfilePic() {
    setState(() {
      profilePic = 'assets/item1.png'; // Example of updating profile pic
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white, // White background
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: AssetImage(profilePic),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _changeProfilePic,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(Icons.edit,
                                  size: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),

              // Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // First Name
                    _buildTextField(label: name),
                    SizedBox(height: 16),

                    // Last Name
                    _buildTextField(label: "Last Name"),
                    SizedBox(height: 16),

                    _buildTextField(label: mobNum),
                    SizedBox(height: 16),

                    _buildTextField(label: "Email"),
                    SizedBox(height: 16),
                    // Submit Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Submit logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(
          color: Colors.pink, // Color of the floating label
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.grey.shade100, // Contrast color for text box
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // No border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.pink, // Highlight color for selected border
            width: 1, // Border width when focused
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildEditableField(
      {required String label,
      required TextEditingController controller,
      required bool isEditing,
      required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100, // Contrast color for editable fields
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: isEditing
                ? TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText:
                          controller.text.isEmpty ? label : controller.text,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                : Text(
                    controller.text.isEmpty ? label : controller.text,
                    style: TextStyle(fontSize: 16),
                  ),
            trailing: GestureDetector(
              onTap: onTap,
              child: Text(
                isEditing ? "Save" : "Update",
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

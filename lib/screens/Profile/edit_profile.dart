import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String profilePic = 'assets/item1.png'; // Default image
  bool isEditingMobile = false;
  bool isEditingEmail = false;

  TextEditingController mobileController = TextEditingController(text: "+91 9876543210");
  TextEditingController emailController = TextEditingController(text: "Example@gmail.com");

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
                              child: Icon(Icons.edit, size: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Test',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    _buildTextField(label: "First Name"),
                    SizedBox(height: 16),

                    // Last Name
                    _buildTextField(label: "Last Name"),
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
                    SizedBox(height: 20),

                    // Contact Info
                    _buildEditableField(
                      label: "Mobile Number",
                      controller: mobileController,
                      isEditing: isEditingMobile,
                      onTap: () {
                        setState(() {
                          isEditingMobile = !isEditingMobile;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    _buildEditableField(
                      label: "Email Id",
                      controller: emailController,
                      isEditing: isEditingEmail,
                      onTap: () {
                        setState(() {
                          isEditingEmail = !isEditingEmail;
                        });
                      },
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
          width: 1,           // Border width when focused
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
                      hintText: label,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                : Text(
                    controller.text,
                    style: TextStyle(fontSize: 16),
                  ),
            trailing: GestureDetector(
              onTap: onTap,
              child: Text(
                isEditing ? "Save" : "Update",
                style: TextStyle(
                    color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

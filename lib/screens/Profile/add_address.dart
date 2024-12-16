import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/authentication/shared_preferences_util.dart'; // Import the geocoding package

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String _selectedAddressType = 'Home';
  String _location = '';
  String _city = '';
  String _pincode = '';
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation(); // Automatically fetch the location when the page loads
  }

  // Check permissions and fetch location
  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = "Location services are disabled.";
      });
      _showLocationServiceDialog();
      return;
    }
    // Save the address to shared preferences

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _location = "Location permission denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _location = "Location permission is permanently denied.";
      });
      _showLocationServiceDialog();
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get city and pincode from geocoding
    try {
      List<Placemark> placemarks =
          await GeocodingPlatform.instance!.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Get the city and pincode from the first placemark
      Placemark placemark = placemarks.first;
      setState(() {
        _city = placemark.locality ?? '';
        _pincode = placemark.postalCode ?? '';
        _location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
      });

      // Auto-fill city and pincode fields
      _cityController.text = _city;
      _pincodeController.text = _pincode;
    } catch (e) {
      setState(() {
        _location = 'Failed to fetch address: $e';
      });
    }
  }

  Future<void> _saveAddress() async {
    // Save address data using the utility class
    await SharedPreferencesUtil.saveString('address_type', _selectedAddressType);
    await SharedPreferencesUtil.saveString('city', _cityController.text);
    await SharedPreferencesUtil.saveString('pincode', _pincodeController.text);

    // Optionally, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Address Saved!')),
    );

    // Pop the current screen after saving the address
    Navigator.pop(context);
  }

  // Dialog to inform the user to enable location services
void _showLocationServiceDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white, // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
      ),
      title: Text(
        "Turn On Location",
        style: TextStyle(
          color: Colors.pinkAccent, // Title color
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Please enable location",
        style: TextStyle(
          color: Colors.black87, // Content text color
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Geolocator.openLocationSettings(); // Opens device location settings
          },
          child: Text(
            "Open Settings",
            style: TextStyle(
              color: Colors.pinkAccent, // Button text color
              fontWeight: FontWeight.bold,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            side: BorderSide(color: Colors.pinkAccent), // Border around the button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners for the button
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black, // Button text color
              fontWeight: FontWeight.bold,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            side: BorderSide(color: Colors.grey), // Border around the button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners for the button
            ),
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address',
            style: TextStyle(color: Colors.black, fontFamily: 'Outfit-Bold')),
        backgroundColor: Color(0xFFFAB2EF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Name, Mobile Number, etc.
              _buildTextField(label: "Name"),
              SizedBox(height: 10),
              _buildTextField(label: "Mobile Number"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Pincode TextField
                  Container(
                    width: 150,
                    child: TextField(
                      controller:
                          _pincodeController, // Use controller for pincode
                      decoration: InputDecoration(
                        labelText: 'Pincode',
                        floatingLabelStyle: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.pink, width: 1),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  // Submit Button
                  Container(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: _getLocation, // Fetch location on button press
                      icon: Icon(
                        Icons.location_on, // Location icon
                        color: Colors.white, 
                        size: 18,// Icon color
                      ),
                      label: Text(
                        'Get Location',
                        style: TextStyle(fontSize: 10, color: Colors.white), // Text color
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFA63C5), // Button background color
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Rounded corners for the button
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // City TextField
              Container(
                width: double.infinity,
                child: TextField(
                  controller: _cityController, // Use controller for city
                  decoration: InputDecoration(
                    labelText: 'City',
                    floatingLabelStyle: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.pink, width: 1),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(label: "House No, Building Name"),
              SizedBox(height: 10),
              _buildTextField(label: "Area, Colony"),
              SizedBox(
                height: 10,
              ),
              // Radio buttons for address type
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAddressType = 'Home';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:
                                  Colors.pink), // Border for button-like style
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: 'Home',
                              groupValue: _selectedAddressType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedAddressType = value!;
                                });
                              },
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Add space between the buttons
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAddressType = 'Apartment';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:
                                  Colors.pink), // Border for button-like style
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: 'Apartment',
                              groupValue: _selectedAddressType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedAddressType = value!;
                                });
                              },
                            ),
                            Text(
                              'Apartment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

               ElevatedButton(
                onPressed: _saveAddress,
                child: Text('Save Address'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFA63C5), // Button color
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({required String label}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle:
            TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.pink, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

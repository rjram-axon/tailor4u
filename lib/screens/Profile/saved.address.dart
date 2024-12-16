import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/authentication/shared_preferences_util.dart';
import 'package:tailor4u/screens/Profile/add_address.dart';

class SavedAddressPage extends StatefulWidget {
  @override
  _SavedAddressPageState createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
List<Map<String, String>> addresses = []; // List to store saved addresses as maps
int? selectedAddressIndex; // To manage the selected address
  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  // Load saved addresses from SharedPreferences
  // Load saved addresses from SharedPreferences
_loadAddresses() async {
  final prefs = await SharedPreferences.getInstance();

  // Fetch saved addresses as a list of JSON strings
  List<String> storedAddresses = prefs.getStringList('saved_addresses') ?? [];

  // Convert each JSON string back into a map
  List<Map<String, String>> deserializedAddresses = storedAddresses
      .map((addressJson) => Map<String, String>.from(jsonDecode(addressJson)))
      .toList();

  // Update the state with the deserialized list
  setState(() {
    addresses = deserializedAddresses;
  });
}



  // Save a new address to SharedPreferences
_saveAddress(Map<String, String> newAddress) async {
  final prefs = await SharedPreferences.getInstance();

  // Convert the map to a JSON string
  String jsonString = jsonEncode(newAddress);

  // Add the new address to the list
  List<String> storedAddresses = prefs.getStringList('saved_addresses') ?? [];
  storedAddresses.add(jsonString);

  // Save the updated list in SharedPreferences
  await prefs.setStringList('saved_addresses', storedAddresses);

  // Reload the addresses to reflect changes in the UI
  _loadAddresses();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // App bar color
        elevation: 0, // No shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Saved Addresses', // Title of the page
          style: TextStyle(color: Colors.black, fontFamily: 'Outfit-Bold'),
        ),
        centerTitle: true, // Center the title
      ),
      body: addresses.isEmpty // Check if addresses list is empty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_rounded,
                        size: 50, color: Colors.grey), // Empty state icon
                    SizedBox(height: 20),
                    Text(
                      'No saved addresses yet.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to AddAddressPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressPage()),
                        );
                      },
                      child: Text('Add New Address'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Color(0xFFFA63C5)),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
Expanded(
  child: ListView.builder(
    itemCount: addresses.length,
    itemBuilder: (context, index) {
      Map<String, String> address = addresses[index];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade100),
          ),
          child: ListTile(
            title: Text(address['address_type'] ?? 'Unknown Address Type'),
            subtitle: Text(
              '${address['city'] ?? ''}, ${address['pincode'] ?? ''}',
            ), // Combine city and pincode
            leading: Icon(Icons.home_rounded, color: Colors.black),
            trailing: Radio(
              value: index,
              groupValue: selectedAddressIndex,
              onChanged: (value) {
                setState(() {
                  selectedAddressIndex = value as int?;
                });
              },
            ),
          ),
        ),
      );
    },
  ),
),
             ],
            ),
    );
  }
}

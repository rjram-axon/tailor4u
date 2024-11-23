import 'package:flutter/material.dart';
import 'package:tailor4u/screens/otp_screen.dart';

class Mobileverify extends StatefulWidget {
  const Mobileverify({super.key});

  @override
  State<Mobileverify> createState() => _MobileverifyState();
}

class _MobileverifyState extends State<Mobileverify> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child:
                        const Icon(Icons.arrow_back, color: Color(0xFF6F4F99)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Get Started with Daily Eats',
                  style: TextStyle(
                    fontFamily: 'Inder',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter Mobile Number to get OTP',
                  style: TextStyle(
                    fontFamily: 'Inder',
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontFamily: 'Inder', fontSize: 18),
                  cursorColor: const Color(0xFF127E09),
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: '10 digit mobile number',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inder',
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                    labelText: 'Mobile Number',
                    counterText: '',
                    labelStyle: const TextStyle(
                      color: Color(0xFF6F4F99),
                      fontFamily: 'Inder',
                    ),
                    prefixText: '+91  ',
                    prefixStyle: const TextStyle(
                      fontFamily: 'Inder',
                      fontSize: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF127E09)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF6F4F99)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Otpverfication(),
                        ),
                      );
                    },
                    child: const Text(
                      'Get OTP',
                      style: TextStyle(
                        fontFamily: 'Inder',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'By Clicking I accept your  ',
                          style: TextStyle(
                            fontFamily: 'Inder',
                            fontSize: 14,
                            color: Colors.black26,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of use and privacy policy',
                          style: TextStyle(
                            fontFamily: 'Inder',
                            fontSize: 14,
                            color: Color(0xFF6F4F99),
                            decoration: TextDecoration.underline,
                          ),
                          // Add functionality for terms and privacy policy links
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

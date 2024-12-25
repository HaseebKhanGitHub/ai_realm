import 'package:ai_realm/helper/myDialog.dart';
import 'package:ai_realm/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:ai_realm/api/appwrite.dart'; // Ensure this points to the file where your `appwrite` class is defined

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final appwriteService =
      appwrite(); // Instance of your custom appwrite class

  Future<void> registerUser(String email, String password) async {
    try {
      final response = await appwriteService.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      myDialog.success('User registered: ${response.email}');
    } catch (e) {
      myDialog.error('Error registering user: $e');
      print("Error is: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      Get.to(() => LoginScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(color: Colors.blue),
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

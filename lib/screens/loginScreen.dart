import 'package:ai_realm/helper/myDialog.dart';
import 'package:ai_realm/screens/homeScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:ai_realm/api/appwrite.dart';
import 'package:ai_realm/screens/signupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final appwriteService = appwrite();

  Future loginUser(String email, String password) async {
    try {
      // Use the correct method for email-password authentication
      final response =
          await appwriteService.account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      // If login successful, show success message
      myDialog.success('Login successful!');
      print('Logged in as: ${response.userId}'); // Use the userId directly

      // Navigate to your home screen or dashboard
      Get.offAll(() => homeScreen());
    } catch (e) {
      myDialog.error('Login failed: $e');
      print("Error is: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Add forgot password functionality
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool? isLoggedIn = await loginUser(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );

                    if (isLoggedIn == true) {
                      Get.offAll(() => homeScreen());
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => SignupScreen());
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: 'Sign up',
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
    );
  }
}

import 'package:ai_realm/api/appwrite.dart';
import 'package:ai_realm/helper/global.dart';
import 'package:ai_realm/model/home_type.dart';
import 'package:ai_realm/screens/loginScreen.dart';
import 'package:ai_realm/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final appwriteService = appwrite();

  Future<void> logout() async {
    try {
      // Attempt to delete the current session (if it exists)
      await appwriteService.account.deleteSession(sessionId: 'current');
      final user = await appwriteService.account.get();
      print("User ID: ${user.$id}");

      print("Email: ${user.email}");
    } catch (e) {
      // If no active session, this will fail silently or you can log the error
      print('No active session or error occurred: $e');
    }

    // Navigate to the LoginScreen
    Get.offAll(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(
                Icons.logout,
                color: Colors.blue,
                size: 26,
              ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.size.width * .04, vertical: mq.size.height * .015),
        children: homeType.values
            .map((e) => home_card(
                  hometype: e,
                ))
            .toList(),
      ),
    );
  }
}

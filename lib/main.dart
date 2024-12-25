import 'package:ai_realm/api/appwrite.dart';
import 'package:ai_realm/helper/global.dart';
import 'package:ai_realm/screens/SplashScreen.dart';
import 'package:ai_realm/screens/homeScreen.dart';
import 'package:ai_realm/screens/loginScreen.dart';
import 'package:ai_realm/screens/signUpScreen.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Builder(
        builder: (context) {
          mq = MediaQuery.of(context); // Initialize mq here
          return SplashScreen(); // Replace with your starting screen
        },
      ),
    );
  }
}

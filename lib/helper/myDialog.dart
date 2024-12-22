import 'package:ai_realm/main.dart';
import 'package:ai_realm/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class myDialog {
  //info
  static void info(String msg) {
    Get.snackbar("Info", msg,
        backgroundColor: Colors.redAccent.shade200,
        colorText: Colors.white,
        duration: Duration(seconds: 2));
  }

//success
  static void success(String msg) {
    Get.snackbar("Success", msg,
        backgroundColor: Colors.redAccent.shade200, colorText: Colors.white);
  }

//error
  static void error(String msg) {
    Get.snackbar("Error", msg,
        backgroundColor: Colors.redAccent.shade200, colorText: Colors.white);
  }

  //loading
  static void showLoading() {
    Get.dialog(Center(
      child: CustomLoading(),
    ));
  }
}

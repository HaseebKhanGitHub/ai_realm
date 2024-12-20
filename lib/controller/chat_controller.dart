/*
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  // Observable list to store messages
  var messages = <Map<String, String>>[].obs;
  final TextEditingController fieldController = TextEditingController();

  // Function to send user message and get response
  void geminiOutput() async {
    if (fieldController.text.trim().isEmpty) {
      return;
    }

    final userInput = fieldController.text;

    // Add user message
    messages.add({"sender": "user", "message": userInput});
    fieldController.text = '';

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyDHALym6iq5EmFIODwFE1UzEwEmXY4GLOo",
    );

    final content = [Content.text(userInput)];
    final response = await model.generateContent(content);

    // Add bot response
    messages
        .add({"sender": "bot", "message": response.text ?? "No response"});
  }
}
*/

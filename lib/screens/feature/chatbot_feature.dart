import 'package:ai_realm/helper/myDialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:get/get.dart'; // Import GetX

class ChatController extends GetxController {
  // Observable list to store messages
  var messages = <Map<String, String>>[].obs;
  final TextEditingController controller = TextEditingController();

  // Function to send user message and get response
  void geminiOutput() async {
    if (controller.text.trim().isEmpty) {
      return myDialog.info("Please write something");
    }
    final userInput = controller.text;

    // Add user message
    messages.add({"sender": "user", "message": userInput});
    controller.text = '';

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

class ChatbotFeature extends StatelessWidget {
  const ChatbotFeature({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller using GetX
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat With AI",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Display messages above the input field
            Expanded(
              flex: 7,
              child: Obx(() {
                // Use Obx to listen to messages list changes
                return ListView.builder(
                  reverse: true,
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController
                        .messages[chatController.messages.length - index - 1];
                    final isUser = message["sender"] == "user";
                    final isLastBotMessage = !isUser && index == 0;

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isUser
                            ? Text(
                                message["message"]!,
                                style: TextStyle(fontSize: 16),
                              )
                            : isLastBotMessage
                                ? AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                          message["message"]!,
                                          speed: Duration(milliseconds: 50))
                                    ],
                                    totalRepeatCount: 1,
                                  )
                                : Text(
                                    message["message"]!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                      ),
                    );
                  },
                );
              }),
            ),
            // Input field and send button
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    // Text input field
                    Expanded(
                      child: TextFormField(
                        controller: chatController.controller,
                        textAlign: TextAlign.center,
                        onTapOutside: (e) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          filled: true,
                          isDense: true,
                          hintText: 'Ask me anything you want...',
                          hintStyle: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Send button
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: chatController.geminiOutput,
                        // Use controller's method
                        icon: const Icon(Icons.rocket_launch_rounded,
                            color: Colors.white, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

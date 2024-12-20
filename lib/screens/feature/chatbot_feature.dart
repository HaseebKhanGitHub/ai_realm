import 'package:ai_realm/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  //new codde
  final TextEditingController fieldController = TextEditingController();
  final List<Map<String, String>> messages = [];

  void geminiOutput() async {
    if (fieldController.text.trim().isEmpty) {
      return;
    }

    final userInput = fieldController.text;

    setState(() {
      // Add user message to the list
      messages.add({"sender": "user", "message": userInput});
      fieldController.text = '';
    });

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyDHALym6iq5EmFIODwFE1UzEwEmXY4GLOo",
    );

    final content = [Content.text(userInput)];
    final response = await model.generateContent(content);

    setState(() {
      // Add bot response to the list
      messages
          .add({"sender": "bot", "message": response.text ?? "No response"});
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - index - 1];
                  final isUser = message["sender"] == "user";

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message["message"]!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
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
                        controller: fieldController,
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
                        onPressed: geminiOutput,
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

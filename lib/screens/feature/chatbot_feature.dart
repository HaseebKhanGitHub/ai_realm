import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  final TextEditingController fieldController = TextEditingController();
  TextEditingController btnController = TextEditingController();
  String output = "Text Output";

  void geminiOutput() async {
    if (fieldController.text.isEmpty) {
      return;
    }
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyDHALym6iq5EmFIODwFE1UzEwEmXY4GLOo",
    );

    final content = [Content.text(fieldController.text)];
    final response = await model.generateContent(content);

    print(response.text);

    setState(() {
      output = response.text!;
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
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),

        //send message field & btn
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(children: [
            //text input field
            Expanded(
                child: TextFormField(
              controller: fieldController,
              textAlign: TextAlign.center,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  isDense: true,
                  hintText: 'Ask me anything you want...',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
            )),

            //for adding some space
            const SizedBox(width: 8),

            //send button
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue,
              // backgroundColor: Theme.of(context).buttonColor,
              child: IconButton(
                onPressed: geminiOutput,
                icon: const Icon(Icons.rocket_launch_rounded,
                    color: Colors.white, size: 28),
              ),
            )
          ]),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Text(output),
                ))
              ],
            ),
          ),
        ));
  }
}

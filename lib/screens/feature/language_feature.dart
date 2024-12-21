import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageFeature extends StatefulWidget {
  TextEditingController outputController = TextEditingController();

  @override
  State<LanguageFeature> createState() => _LanguageFeatureState();
}

class _LanguageFeatureState extends State<LanguageFeature> {
  String inputText = '';
  String inputLanguage = 'en';
  String outputLanguage = 'fr';
  final GoogleTranslator translator = GoogleTranslator();
  TextEditingController outputController =
      TextEditingController(text: "Results here...");

  Future<void> translateText() async {
    final translated = await translator.translate(inputText,
        from: inputLanguage, to: outputLanguage);
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Language Translator",
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  // Add a controller if needed
                  // controller: ,
                  textAlign: TextAlign.center,
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    isDense: true,
                    hintText: 'Type here to translate the text',
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                    });
                  },
                  maxLines: 10,
                ),
                //  SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                          value: inputLanguage,
                          items: <String>['en', 'fr', 'es', 'de', 'ur', 'hi']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              inputLanguage = newValue!;
                            });
                          }),
                      Icon(Icons.arrow_forward),
                      DropdownButton(
                          value: outputLanguage,
                          items: <String>['en', 'fr', 'es', 'de', 'ur', 'hi']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              outputLanguage = newValue!;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  // Add a controller if needed
                  controller: outputController,
                  textAlign: TextAlign.center,
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    isDense: true,
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                    });
                  },

                  maxLines: 10,
                ),
                SizedBox(height: 60),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: translateText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      // Set button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Optional: Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Button height adjustment
                    ),
                    child: const Text(
                      "Translate",
                      style: TextStyle(
                        color: Colors.white, // Set text color
                        fontSize: 16, // Optional: Font size
                        fontWeight: FontWeight.bold, // Optional: Bold text
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}

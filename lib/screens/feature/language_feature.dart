import 'package:flutter/material.dart';

class LanguageFeature extends StatefulWidget {
  const LanguageFeature({super.key});

  @override
  State<LanguageFeature> createState() => _LanguageFeatureState();
}

class _LanguageFeatureState extends State<LanguageFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat With AI"),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

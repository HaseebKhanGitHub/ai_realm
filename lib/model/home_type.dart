import 'package:ai_realm/screens/feature/chatbot_feature.dart';
import 'package:ai_realm/screens/feature/image_feature.dart';
import 'package:ai_realm/screens/feature/language_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum homeType { aiChatbot, aiImgage, aiTranslator }

extension myHomeType on homeType {
  String get title => switch (this) {
        homeType.aiChatbot => "AI Chatbot",
        homeType.aiImgage => "AI Image Generator",
        homeType.aiTranslator => "AI Language Translator",
      };

  String get lottie => switch (this) {
        homeType.aiChatbot => "ai_hand_waving.json",
        homeType.aiImgage => "ai_play.json",
        homeType.aiTranslator => "ai_ask_me.json",
      };

  bool get leftAlign => switch (this) {
        homeType.aiChatbot => true,
        homeType.aiImgage => false,
        homeType.aiTranslator => true,
      };

  EdgeInsets get padding => switch (this) {
        homeType.aiChatbot => EdgeInsets.zero,
        homeType.aiImgage => const EdgeInsets.all(20),
        homeType.aiTranslator => EdgeInsets.zero,
      };

  VoidCallback get onTap => switch (this) {
        homeType.aiChatbot => () => Get.to(() => ChatbotFeature()),
        homeType.aiImgage => () => Get.to(() => ImageFeature()),
        homeType.aiTranslator => () => Get.to(() => const LanguageFeature()),
      };
}

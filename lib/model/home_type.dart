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
}

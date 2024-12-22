import 'package:ai_realm/helper/global.dart';
import 'package:ai_realm/helper/myDialog.dart';
import 'package:ai_realm/widgets/custom_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'dart:io'; // For working with files
import 'package:path_provider/path_provider.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  // Controller for the input field
  final TextEditingController _queryController = TextEditingController();

  // Instance of StabilityAI for image generation
  final StabilityAI _ai = StabilityAI();

  // API key for the AI service
  final String apiKey = 'sk-M96eZMJk00bqeC160zPAJcl4RsRIsywvHagLiSExO8ZkJXT4';

  // Set the style for the generated image
  final ImageAIStyle imageAIStyle = ImageAIStyle.aivazovskyPainter;

  // Flag to check if images have been generated
  bool isItems = false;

  // Function to generate an image based on the input query
  Future _generate(String query) async {
    var image = await _ai.generateImage(
      apiKey: apiKey, // API key
      imageAIStyle: imageAIStyle, // Style for the image
      prompt: query, // The text prompt input by the user
    );
    return image; // Return the generated image as bytes
  }

  // Dispose method to clean up the controller when the widget is removed from the tree
  @override
  void dispose() {
    _queryController.dispose(); // Dispose of the controller
    super.dispose(); // Call the super class dispose method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AI Image Generator",
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
      body: Column(
        children: [
          const Spacer(),
          isItems // Check if images have been generated
              ? FutureBuilder(
                  future: _generate(
                      _queryController.text), // Call the generate function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while waiting for the image
                      return const Center(
                        child: CustomLoading(),
                      );
                    } else if (snapshot.hasData) {
                      // If data is received, display the generated image
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                            snapshot.data!), // Display the image from memory
                      );
                    } else {
                      return Container(); // Return an empty container if no data
                    }
                  },
                )
              : Expanded(
                  flex: 4,
                  child: Container(
                    height: mq.height * 0.50,
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'assets/lottie/ai_play.json',
                      height: mq.height * 0.35,
                    ),
                  ),
                ),
          const Spacer(flex: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              // Add a controller if needed
              controller: _queryController,
              textAlign: TextAlign.center,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                filled: true,
                isDense: true,
                hintText: 'Turn your imagination into reality...',
                hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              minLines: 2,
              maxLines: 2,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  String query = _queryController.text; // Get the input text
                  if (query.isNotEmpty) {
                    setState(() {
                      isItems =
                          true; // Set the flag to indicate images are being generated
                    });
                  } else {
                    myDialog.info(
                        "Please provide some details for image generation");
                  } ///////////////////////
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  // Set button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25), // Optional: Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Button height adjustment
                ),
                child: const Text(
                  "Generate",
                  style: TextStyle(
                    color: Colors.white, // Set text color
                    fontSize: 16, // Optional: Font size
                    fontWeight: FontWeight.bold, // Optional: Bold text
                  ),
                ),
              ),
            ),
          ),
          //const Spacer(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                /*FloatingActionButton(
                  onPressed: _downloadImage,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    Icons.save_alt_rounded,
                    color: Colors.white,
                  ),
                ),*/
              ],
            ),
          ))
        ],
      ),
    );
  }

  void _downloadImage() async {
    try {
      // Ensure you have the image bytes from the generated image
      final imageBytes = await _generate(_queryController.text);

      if (imageBytes != null) {
        // Get the temporary directory of the device
        final directory = await getTemporaryDirectory();

        // Define the file path
        final filePath = '${directory.path}/generated_image.png';

        // Write the bytes to a file
        final file = File(filePath);
        await file.writeAsBytes(imageBytes);

        // Save the image to the gallery
        final success = await GallerySaver.saveImage(filePath);

        if (success == true) {
          myDialog.success("Image Saved Successfully!");
        } else {
          myDialog.error("Failed to save the image.");
        }
      } else {
        myDialog.info("No image to save. Please generate an image first.");
      }
    } catch (e) {
      myDialog.error("An error occurred: $e");
    }
  }
}

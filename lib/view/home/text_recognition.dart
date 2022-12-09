import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!textScanning && imageFile == null)
                  textScanning
                      ? const CupertinoActivityIndicator()
                      : Container(
                          height: 300,
                          width: 300,
                          color: Colors.black,
                        ),
                if (imageFile != null)
                  Image.file(
                    File(imageFile!.path),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Gallery'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text('camera'),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    scannedText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImage(source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        textRecognition(pickedImage);
      } else {
        Get.snackbar('error', 'please any image');
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = 'Error while Selcting Image';
    }
  }

  void textRecognition(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = '';
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = '$scannedText  ${line.text}  \n';
      }
    }
    textScanning = false;
    log(scannedText);
    setState(() {});
  }
}

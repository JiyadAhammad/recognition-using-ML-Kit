import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.black,
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
                )
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
      } else {
        Get.snackbar('error', 'please any image');
      }
    } catch (e) {}
  }
}

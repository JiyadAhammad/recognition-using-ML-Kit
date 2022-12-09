import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recognition/view/constant/sizedbox/sizedbox.dart';
import 'package:recognition/view/fingerprint/api/auth_api.dart';
import 'package:recognition/view/home/text_recognition.dart';

class BiometricTest extends StatelessWidget {
  const BiometricTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text(
          'BioMetric',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            testAvailbe(),
            kheight20,
            buildAuthencate(),
          ],
        ),
      ),
      //  IconButton(onPressed: (){}, icon: Icon(Icons.)),),
    );
  }

  Widget buildAuthencate() {
    return ElevatedButton(
      onPressed: () async {
        final isAvailable = await FingerPrintAuthApi.hasBiometric();
        log('$isAvailable check availability ');
      },
      child: const Text(
        'avialabe',
      ),
    );
  }

  Widget testAvailbe() {
    return ElevatedButton(
      onPressed: () async {
        final isAuthenticate = await FingerPrintAuthApi.authenticate();
        if (isAuthenticate) {
          Get.to(() => const TextRecognitionScreen());
        }
      },
      child: const Text(
        'biometreic',
      ),
    );
  }
}

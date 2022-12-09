import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recognition/view/constant/color/colors.dart';
import 'package:recognition/view/voice/api/speech_api.dart';

class VoiceRecognition extends StatefulWidget {
  const VoiceRecognition({Key? key}) : super(key: key);

  @override
  State<VoiceRecognition> createState() => _VoiceRecognitionState();
}

class _VoiceRecognitionState extends State<VoiceRecognition> {
  String text = 'welcome';
  bool isListening = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('Speech To Text'),
        centerTitle: true,
        backgroundColor: ktransparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await FlutterClipboard.copy(text);
              Get.snackbar(
                'success',
                'Message copied to clipBoard',
              );
            },
            icon: const Icon(
              Icons.copy,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ).copyWith(bottom: 150),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        glowColor: Theme.of(context).hoverColor,
        child: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () {},
          child: IconButton(
            onPressed: ontap,
            icon: Icon(
              isListening ? Icons.mic : Icons.mic_off,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Future ontap() {
    log('message call');
    return SpeechApi.toggleRecording(
      onResults: (text) => setState(() {
        log(text);
        this.text = text;
      }),
      onListening: (isListening) => setState(() {
        log('$isListening listening to audio');
        this.isListening = isListening;
      }),
    );
  }
}

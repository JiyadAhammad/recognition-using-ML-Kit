import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final SpeechToText speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResults,
    required ValueChanged<bool> onListening,
  }) async {
    final bool isAvailable = await speech.initialize(
      onStatus: (status) => onListening(
        speech.isListening,
      ),
      onError: (errorNotification) =>
          log('Error while Listening $errorNotification'),
    );

    if (isAvailable) {
      speech.listen(
        onResult: (result) => onResults(
          result.recognizedWords,
        ),
      );
    }
    return isAvailable;
  }
}

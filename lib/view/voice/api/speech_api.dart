import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final SpeechToText speech = SpeechToText();

  static Future<bool> toggleRecording({
     required Function(String text) onResults,
  }) async {
    final bool isAvailable = await speech.initialize();
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

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintAuthApi {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> hasBiometric() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      log('$e hasBiometric error');
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometric();
    if (!isAvailable) return false;
    try {
      return await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      log('$e biometric error');
      return false;
    }
  }
}

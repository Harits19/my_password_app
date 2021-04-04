import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    return authenticated;
  }

  static Future<bool> isDeviceSupported() async {
    late bool isSupported;
    late bool canCheckBiometrics;
    try {
      isSupported = await auth.isDeviceSupported();
      canCheckBiometrics = await auth.canCheckBiometrics;
      if (isSupported && canCheckBiometrics) return true;
      return false;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}

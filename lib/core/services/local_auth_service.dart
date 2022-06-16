import 'package:local_auth/local_auth.dart';

class LocalAuthServiceV2 {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Let OS determine authentication method',
    );
  }

  Future<bool> isDeviceSupported() async {
    try {
      final isSupported = await auth.isDeviceSupported();
      final canCheckBiometrics = await auth.canCheckBiometrics;
      return (isSupported && canCheckBiometrics);
    } catch (e) {
      return false;
    }
  }
}

class LocalAuthService {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Let OS determine authentication method',
    );
  }

  static Future<bool> isDeviceSupported() async {
    try {
      final isSupported = await auth.isDeviceSupported();
      final canCheckBiometrics = await auth.canCheckBiometrics;
      return (isSupported && canCheckBiometrics);
    } catch (e) {
      return false;
    }
  }
}

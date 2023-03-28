import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final auth = LocalAuthentication();

 static Future<bool> authenticate() {
    return LocalAuthentication().authenticate(
      localizedReason: 'App Security',
      options: AuthenticationOptions(
        biometricOnly: true,
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final localAuthServicer = Provider<LocalAuthService>((ref) {
  return LocalAuthService();
});

class LocalAuthService {
  final auth = LocalAuthentication();

  Future<bool> authenticate() {
    return LocalAuthentication().authenticate(
      localizedReason: 'App Security',
      options: AuthenticationOptions(
        biometricOnly: true,
      ),
    );
  }
}

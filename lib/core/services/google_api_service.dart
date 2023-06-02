import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

final googleApiService = Provider<GoogleApiService>((ref) {
  return GoogleApiService();
});

class GoogleApiService {
  final googleSignIn = GoogleSignIn.standard(scopes: [DriveApi.driveFileScope]);

  Future<GoogleSignInAccount> signIn() async {
    final account = await googleSignIn.signIn();
    if (account == null) throw 'Empty user';
    print('signIn $account');
    return account;
  }

  Future<GoogleSignInAccount?> signOut() async {
    print('signOut');
    return googleSignIn.disconnect();
  }
}

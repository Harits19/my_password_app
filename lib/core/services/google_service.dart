import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/models/user_model.dart';

class GoogleService {
  GoogleService._();

  static final _google = GoogleSignIn();

  static Future<UserModel> signInWithGoogle() async {
    final googleUser = await _google.signIn();

    print("google user => " + googleUser.toString());

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final firebaseCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("firebase credential => " + firebaseCredential.toString());
    return firebaseCredential;
  }

  static Future<UserModel?> checkCurrentUser() async {
    if (await _google.isSignedIn() == false) {
      return null;
    }
    return await signInWithGoogle();
  }

  static Future<void> signOutWithGoogle() async {
    await _google.disconnect();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_password_app/core/models/user_model.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as google;

class GoogleService {
  GoogleService._();

  static final _google = google.GoogleSignIn.standard(scopes: [
    drive.DriveApi.driveScope,
  ]);

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
    if (googleUser == null) throw "Empty Google User";
    return UserModel(
        userCredential: firebaseCredential, googleSignInAccount: googleUser);
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/models/user_model.dart';

class GoogleService {
  GoogleService._();

  static Future<UserModel> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("google user => " + googleUser.toString());
    print("google auth => " + googleAuth.toString());
    print("credential => " + credential.toString());
    // Once signed in, return the UserCredential
    final firebaseCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("firebase credential => " + firebaseCredential.toString());
    return firebaseCredential;
  }
}

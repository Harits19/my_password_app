import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  UserCredential userCredential;
  GoogleSignInAccount googleSignInAccount;

  UserModel({
    required this.userCredential,
    required this.googleSignInAccount,
  });
}

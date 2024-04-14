import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initialize GoogleSignIn with client ID
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "16043473379-k1oqol4v6lk9hnd69sb91ecf52mdm1fo.apps.googleusercontent.com",
  );

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // google sign in
  Future<void> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  // Get user
  Future<User?> getUser() async {
    return _auth.currentUser;
  }
}
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initialize GoogleSignIn with client ID
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "16043473379-k1oqol4v6lk9hnd69sb91ecf52mdm1fo.apps.googleusercontent.com",
  );

  get currentUser => null;

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

  // login with email and order id
  Future<void> loginWithEmail(String email, String orderId) async {
    try {
      // Get the user document from the database using the provided email and order id
      final userDoc = await DBProvider().getUserByEmailAndOrderId(email, orderId);

      if (userDoc == null) {
        // User not found in the database
        throw Exception("User not found");
      }

      // Sign in the user with the retrieved user document
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e.toString());
      throw Exception("Login failed");
    }
  }

  // Get user
  Future<User?> getUser() async {
    return _auth.currentUser;
  }
}

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

  // Send sign-in link to email
  Future<void> sendSignInEmailLink(String email) async {
    final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://your-app.com/login?email=$email',
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );

    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
      print('Sign-in email sent');
    } on FirebaseAuthException catch (e) {
      print('Failed to send sign-in email: ${e.message}');
      throw Exception('Failed to send sign-in email');
    }
  }

  // Sign in with email link
  Future<void> signInWithEmailLink(String email, String emailLink) async {
    try {
      final userCredential = await _auth.signInWithEmailLink(email: email, emailLink: emailLink);
      print('Signed in with email link: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
      throw Exception('Sign-in with email link failed');
    }
  }

  // Get user
  Future<User?> getUser() async {
    return _auth.currentUser;
  }
}

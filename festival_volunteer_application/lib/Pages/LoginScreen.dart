import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/LoginButton.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:festival_volunteer_application/services/AuthService.dart';

import '../Utility/UserHandler.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _db_provider = DBProvider();
  final _auth_provider = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Check if the user is already logged in
    AuthService().userStream.listen((user) {
      if (user != null) {
        // Print the user.uid
        print('UserID: ${user.uid}');
        print('User email: ${user.email}');
        print('User display name: ${user.displayName}');
        // Get the user
        Future<FestivalGuest> festivalGuest = _db_provider.getFestivalGuest(user);
        festivalGuest.then((currentUserSnapshot) {
          UserHandler().user = currentUserSnapshot;
          // Get the order ID from the snapshot
          bool hasOrderID = currentUserSnapshot.orderID != 0;
          if (hasOrderID) {
            Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
          } else {
            Navigator.pushNamed(context, '/link-ticket');
          }
        });
      } else if (UserHandler().user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
void _loginWithEmail() async {
  try {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Handle successful login
    print('User logged in: ${userCredential.user!.uid}');
  } on FirebaseAuthException catch (e) {
    // Handle login errors
    print('User login failed: ${e.message}');

    if (e.code == 'user-not-found' || e.code == 'The supplied auth credential is incorrect, malformed or has expired.') {
      Navigator.pushNamedAndRemoveUntil(context, '/register-non-google-user', ((route) => false));
      // Handle case where user doesn't exist
      // You may choose to show an error message or navigate to a registration screen
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      // Handle case where password is incorrect
      print('Wrong password provided for that user.');
    } else {
      // Handle other errors
      print('Failed to login: ${e.message}');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              child: Image(image: AssetImage('assets/images/app_icon.png')),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Flexible(
              child: LoginButton(
                text: 'Log ind med email og password',
                icon: FontAwesomeIcons.envelope,
                color: Colors.grey,
                loginMethod: _loginWithEmail,
              ),
            ),
            Flexible(
              child: LoginButton(
                text: 'Log ind med Google',
                icon: FontAwesomeIcons.google,
                color: Colors.grey,
                loginMethod: _auth_provider.googleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

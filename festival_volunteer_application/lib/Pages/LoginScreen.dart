import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/LoginButton.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:festival_volunteer_application/services/AuthService.dart';

import '../Utility/GlobalHandler.dart';

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
          GlobalHandler().user = currentUserSnapshot;
          // Get the order ID from the snapshot
          bool hasOrderID = currentUserSnapshot.orderID != 0;
          if (hasOrderID) {
            Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
          } else {
            Navigator.pushNamed(context, '/link-ticket');
          }
        });
      } else {
        print('No user logged in');
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

      // If the email ends with @gmail.com, then the user is a Google user
      if (email != null && email.endsWith('@gmail.com')) {
        print('Brugeren er en Google-bruger');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Log ind med Google i stedet for email og password.')),
        );
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      // Håndter loginfejl
      print('Brugerlogin mislykkedes: ${e.message}');

      if (e.code == 'user-not-found' || e.message == 'The supplied auth credential is incorrect, malformed or has expired.') {
        print('Den korrekte kode er blevet kaldt!: ${e.message}');
        // Håndter tilfælde hvor brugeren ikke eksisterer
        // Du kan vælge at vise en fejlmeddelelse eller navigere til en registreringsskærm
        print('Ingen bruger fundet med den e-mail.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ingen bruger fundet med denne e-mail.')),
        );
        // Naviger til registreringsskærmen
        Navigator.pushNamed(context, '/register-non-google-user');
      } else if (e.code == 'wrong-password') {
        // Håndter tilfælde hvor adgangskoden er forkert
        print('Forkert adgangskode angivet for den bruger.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Forkert adgangskode angivet for denne bruger.')),
        );
      } else {
        // Håndter andre fejl
        print('Fejl ved login: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fejl ved login: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_backdrop_V1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/login_screen_sticker.png', height: 200),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  fillColor: Color.fromARGB(255, 210, 232, 198).withOpacity(0.85),
                  filled: true,
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Ordre ID (Password)',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 210, 232, 198)?.withOpacity(0.85),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Flexible(
                child: LoginButton(
                  text: 'Log ind med email og password',
                  icon: FontAwesomeIcons.envelope,
                  color: Color.fromARGB(255, 210, 232, 198)!.withOpacity(0.85),
                  loginMethod: _loginWithEmail,
                ),
              ),
              Flexible(
                child: LoginButton(
                  text: 'Log ind med Google',
                  icon: FontAwesomeIcons.google,
                  color: Color.fromARGB(255, 210, 232, 198)!.withOpacity(0.85),
                  loginMethod: _auth_provider.googleLogin,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF4C5E49),
    );
  }
}
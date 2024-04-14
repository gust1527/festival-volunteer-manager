import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:festival_volunteer_application/services/auth.dart';
import 'package:festival_volunteer_application/UX_Elements/LoginButton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final dbProvider = db_provider();

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
              child: Icon(Icons.golf_course),
              //child: Image.asset('assets/images/festival_logo_image.png'),
            ),
            Flexible(
              child: SizedBox(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Sign in with Google asynchronously
                    await AuthService().googleLogin();

                    // Once login is successful, get the user from the database
                    AuthService().userStream.listen((user) {
                      if (user != null) {
                        // Log the user
                        print(user.uid);

                        dbProvider.getFestivalGuest(user.uid);
                        Navigator.pushNamed(context, '/');
                      }
                    });
                  },
                  icon: const Icon(FontAwesomeIcons.google),
                  label: const Text("Login with Google"),
                ),
              ),
            ),
            const Flexible(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Link din email med din billet',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

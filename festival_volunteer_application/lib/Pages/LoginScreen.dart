import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:festival_volunteer_application/services/auth.dart';
import 'package:festival_volunteer_application/UX_Elements/LoginButton.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    await AuthService().googleLogin();
                  },
                  icon: const Icon(FontAwesomeIcons.google),
                  label: const Text("Login with Google"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

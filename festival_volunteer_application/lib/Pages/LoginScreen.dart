import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:festival_volunteer_application/services/auth.dart';
import 'package:festival_volunteer_application/UX_Elements/LoginButton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final dbProvider = DBProvider();

  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    AuthService().userStream.listen((user) {
      if (user != null) {
        // Get the user
        Future<FestivalGuest> festivalGuest = dbProvider.getFestivalGuest(user.uid);

        festivalGuest.then((snapshot) {
          // Get the order ID from the snapshot
          bool hasOrderID = snapshot.orderID != 0;

          if (hasOrderID) {
            Navigator.pushNamed(context, '/');
          } else {
            Navigator.pushNamed(context, '/link-ticket');
          }
        });
      }
    });

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              child: Icon(Icons.festival, size: 400, color: Colors.green),
              //child: Image.asset('assets/images/festival_logo_image.png'),
            ),
            Flexible(
              child: SizedBox(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Sign in with Google asynchronously
                    await AuthService().googleLogin();
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

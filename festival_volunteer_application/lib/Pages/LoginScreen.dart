import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/LoginButton.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:festival_volunteer_application/services/AuthService.dart';

import '../Utility/UserHandler.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _db_provider = DBProvider();
  final _auth_provider = AuthService();

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              child: Image(image: AssetImage('assets/images/app_icon.png')),
              //child: Image.asset('assets/images/festival_logo_image.png'),
            ),
            Flexible(
              child: LoginButton(
                text: 'Log ind med Google',
                icon: FontAwesomeIcons.google,
                color: Colors.grey,
                loginMethod: _auth_provider.googleLogin,
              ),
            ),
            Flexible(
              child: LoginButton(
                text: 'Log ind med email og ordre ID',
                icon: FontAwesomeIcons.envelope,
                color: Colors.grey,
                loginMethod: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

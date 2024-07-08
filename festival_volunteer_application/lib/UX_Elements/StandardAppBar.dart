import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/AuthService.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:festival_volunteer_application/Utility/UserHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _auth = AuthService();
  final _db = DBProvider();
  late final UserHandler _userHandler = UserHandler();
  late final String tjanseName; // The name of the first tjanse

  StandardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the festivalGuest from the userHandler
    final FestivalGuest festivalGuest = _userHandler.user!;

    // Get the first tjans from the user
    final Future<String> tjans = festivalGuest.tjanser[0].then((value) => tjanseName = value.name);

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Padding(
        padding: EdgeInsets.only(left: 10, top: 40),
        child: Text(
          'ØF 24',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 30,
            fontFamily: 'OedstedFestival',
          ),
        ),
      ),
      backgroundColor: const Color(0xFF4C5E49),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OedstedFestival',
                  ),
                  contentTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OedstedFestival',
                  ),
                  title: const Center(child: Text('ØF 24!')),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Navn: ${festivalGuest.firstName}'),
                      Text('Email: ${festivalGuest.eMail}'),
                      Text('Ordre-id: ${festivalGuest.orderID}'),
                      Text('Tjans: ${tjanseName}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Log ud'),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', ((route) => false));
                      },
                    ),
                    TextButton(
                      child: const Text('Luk'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
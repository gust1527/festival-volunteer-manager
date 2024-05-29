import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/AuthService.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _auth = AuthService();
  final _db = DBProvider();
  late final FestivalGuest festivalGuest;

  StandardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current festivalGuest
    User? currentUser = _auth.user!;

    // Get the user
    Future<FestivalGuest> festivalGuestSnapshot = _db.getFestivalGuest(currentUser);

    festivalGuestSnapshot.then((snapshot) {
      // Get the order ID from the snapshot
      festivalGuest = FestivalGuest.fromJson(snapshot.toJson());
    });

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Padding(
        padding: EdgeInsets.only(top: 18),
        child: Text(
          'ØF 24!',
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
                  title: const Center(child: const Text('ØF 24!')),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Navn: ${festivalGuest.firstName}'),
                      Text('Email: ${festivalGuest.eMail}'),
                      Text('Ordre-id: ${festivalGuest.orderID}'),
                      Text('Tjans: ${festivalGuest.tjans}'),
                      // Add more fields as needed
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Log ud'),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.of(context).pushNamed('/login');
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
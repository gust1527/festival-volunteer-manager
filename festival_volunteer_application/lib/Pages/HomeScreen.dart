import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/auth.dart';
import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBProvider _db = DBProvider();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn;
    Future<bool> hasTjans = Future.value(false);
    String tjans = '';
    String userID = '';

    AuthService().userStream.listen((user) {
      if (user != null) {
        setState(() {
          isLoggedIn = true;
          userID = user.uid;
          hasTjans = _db.hasTjans(user.uid);
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });

    return FutureBuilder(
        future: hasTjans,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return Scaffold(
                appBar: const StandardAppBar(),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ExpandedDialogTile(
                        title: _db.getTjans(userID),
                        content: 'Lørdag: 12:00 - 17:00',
                        route: '/tjanser',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ExpandedDialogTile(
                        title: Future.value('Relevant information'),
                        content: 'Volleyball kl. 12:00',
                        route: '/information',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ExpandedDialogTile(
                                title: Future.value('Musik program'),
                                content:
                                    'Find ud af hvilken dag, der rykker mest for dig!',
                                route: '/music'),
                          ),
                          Expanded(
                              child: ExpandedDialogTile(
                                  title: Future.value('Madboder'),
                                  content: "Få noget i mavsen!",
                                  route: '/foodAndBeverages')),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }
}

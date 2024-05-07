import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/auth.dart';
import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBProvider _db = DBProvider();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(),
      body: StreamBuilder<User?>(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          // Check the state of the snapshot
          bool isLoading = snapshot.connectionState == ConnectionState.waiting;
          bool isLoggedIn = snapshot.hasData;
          bool hasError = snapshot.hasError;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (isLoggedIn) {
            // Get the user from the snapshot
            User? user = snapshot.data;

            bool hasUser = user != null;

            if (hasUser) {
              // Return a FutureBuilder that listens to the getFestivalGuest method from DBProvider
              return FutureBuilder<FestivalGuest>(
                future: _db.getFestivalGuest(user.uid),
                builder: (BuildContext context, AsyncSnapshot<FestivalGuest> snapshot) {
                  // Check the state of the snapshot
                  bool isLoading = snapshot.connectionState == ConnectionState.waiting;
                  bool hasData = snapshot.hasData;
                  bool hasError = snapshot.hasError;

                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (hasData) {
                    // Get the festivalGuest from the snapshot
                    FestivalGuest festivalGuest = snapshot.data!;

                    return Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ExpandedDialogTile(
                            title: festivalGuest.tjans,
                            content: 'Yo yo yo! Velkommen til "Tjanse-siden"! Herunder vil du finde information omkring din tjans.',
                            route: '/tjanser',
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(); // Placeholder widget
                  }
                },
              );
            } else {
              return const Center(
                child: Text("User not logged in!"),
              );
            }
          } else {
            return Container(); // Placeholder widget
          }
        },
      ),
    );
  }
}

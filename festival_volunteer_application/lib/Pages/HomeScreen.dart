import 'package:festival_volunteer_application/Providers/gcal_provider.dart';
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
  final GCAlProvider _gcal = GCAlProvider(calendarId: 'Artister');
  late final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
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

            // Fetch events from Google Calendar
            //print(_gcal.getCalendarEvents());

            if (user != null) {
              // Return a FutureBuilder that listens to the getFestivalGuest method from DBProvider
              return FutureBuilder<FestivalGuest>(
                future: _db.getFestivalGuest(user),
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

                    // Return the contents of the homeScreen
                    return Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ExpandedDialogTile(
                            title: 'Din tjans',
                            content: 'Du har fået tjansen ${festivalGuest.tjans}, som indebærer ${festivalGuest.tjans}. Du skal møde til tjansen kl ${festivalGuest.tjans}',
                            route: '/tjanser',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ExpandedDialogTile(
                            title: 'Relevant information',
                            content: 'Du har fået tjansen ${festivalGuest.tjans}, som indebærer ${festivalGuest.tjans}. Du skal møde til tjansen kl ${festivalGuest.tjans}',
                            route: '/information',
                          ),
                        ),
                        Expanded(child: Row(children: <Widget>[
                          const Expanded(child: ExpandedDialogTile(
                            title: 'Musik-program',
                            content: 'Jim Daggerhurtet spiller på scenen kl 14:00. Husk at tjekke programmet for flere informationer!',
                            route: '/music',
                          )),
                          Expanded(child: ExpandedDialogTile(
                            title: 'Madboder',
                            content: 'Du har fået tjansen ${festivalGuest.tjans}, som indebærer ${festivalGuest.tjans}. Du skal møde til tjansen kl ${festivalGuest.tjans}',
                            route: '/foodAndBeverages',
                          )),
                        ],))
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

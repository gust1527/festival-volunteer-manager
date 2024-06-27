import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/gcal_provider.dart';
import 'package:festival_volunteer_application/Utility/UserHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/AuthService.dart';
import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../Utility/Tjans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBProvider _db = DBProvider();
  final AuthService _auth = AuthService();
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
            Future<Tjans> guestTjans = UserHandler().user!.tjanser[0];
            // Get the user from the snapshot
            User? user = snapshot.data;

            if (user != null) {
              // Return a FutureBuilder that listens to the getFestivalGuest method from DBProvider
              return Column(
                children: <Widget>[
                  FutureBuilder(future: guestTjans, builder: (BuildContext context, AsyncSnapshot<Tjans> snapshot) {
                    if(!snapshot.hasData) {
                      return Center(child: Text(snapshot.toString()));
                    } else {
                      DateTime dateTime = snapshot.requireData.time.toDate();

                      String formattedTime = DateFormat('EEEE d. MMMM @ HH:mm', 'da_DK').format(dateTime);
                      return Expanded(
                          flex: 1,
                          child: ExpandedDialogTile(
                            title: 'Din tjans',
                            content: 'Du har fået tjansen "${snapshot.requireData.name}", som indebærer at "${snapshot.requireData.shortDescription}". Du skal møde til tjansen "$formattedTime"',
                            route: '/tjanser',
                          )
                      );
                    }
                  }),
                  Expanded(
                    flex: 1,
                    child: ExpandedDialogTile(
                      title: 'Relevant information',
                      content: 'Du har fået tjansen TODO, som indebærer . Du skal møde til tjansen kl ',
                      route: '/information',
                    ),
                  ),
                  Expanded(child: Row(children: <Widget>[
                    const Expanded(child: ExpandedDialogTile(
                      title: 'Musik program',
                      content: 'Jim Daggerhurtet spiller på scenen kl 14:00. Husk at tjekke programmet for flere informationer!',
                      route: '/music',
                    )),
                    Expanded(child: ExpandedDialogTile(
                      title: 'Madboder',
                      content: 'Du har fået tjansen , som indebærer . Du skal møde til tjansen kl ',
                      route: '/foodAndBeverages',
                    )),
                  ],))
                ],
              );
              /*
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
                        ;
                  } else {
                    return Container(); // Placeholder widget
                  }
                },
              );
              */
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

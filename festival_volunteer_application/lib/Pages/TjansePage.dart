import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/Services/auth.dart';
import 'package:festival_volunteer_application/Providers/htttp_provider.dart';
import 'package:http/http.dart' as http;


class TjansePage extends StatefulWidget {
  const TjansePage({super.key});

  @override
  _TjansePageState createState() => _TjansePageState();
}

class _TjansePageState extends State<TjansePage> {
  late final _db = db_provider();
  late final _http_provider = HttpProvider();

    @override
    Widget build(BuildContext context) {
  // Get the authenticated user
  final User? user = AuthService().user;

  // Get the user from the DB
  Future<FestivalGuest> festivalGuest = _db.getFestivalGuest(user!.uid);

  // Define local variable to tjans
  Future<Tjans> guestTjans;

  return FutureBuilder<FestivalGuest>(
    future: festivalGuest,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Show a loading spinner while waiting
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // Show error message if something went wrong
      } else {
        // Get the user email
        String guestEmail = snapshot.data!.eMail;

        // Make a HTTP request to the backend to get the user
        try {
          guestTjans = _http_provider.getGuestTjans(guestEmail);
        } catch (e) {
          // Handle the exception and return a default value
          rethrow;
        }

        

        return FutureBuilder<Tjans>(
          future: guestTjans,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show a loading spinner while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Show error message if something went wrong
            } else {
              return Scaffold(
                appBar: StandardAppBar(),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ExpandedDialogTile(
                        title: 'Fedt at du vil hjælpe til!!', 
                        content: snapshot.data!.tjanseDescription, 
                        route: '/tjanser'
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ExpandedDialogTile(
                        title: '(DIN VAGT)', 
                        content: 'Du har fået tjansen (XXX), som indebærer (XXX). Du skal møde til tjansen kl (XXX)', 
                        route: '/tjanser'
                      ),
                    ),      
                  ], 
                ),
              );
            }
          },
        );
      }
    },
  );
}
}
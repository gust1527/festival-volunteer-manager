import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/TjansTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:festival_volunteer_application/Services/auth.dart';
import 'package:festival_volunteer_application/Providers/htttp_provider.dart';

class TjansePage extends StatefulWidget {
  const TjansePage({Key? key}) : super(key: key);

  @override
  _TjansePageState createState() => _TjansePageState();
}

class _TjansePageState extends State<TjansePage> {
  late final _db = DBProvider();
  late final _http_provider = HttpProvider();

  @override
  Widget build(BuildContext context) {
    // Get the authenticated user
    final User? user = AuthService().user;

    // Get the user from the DB
    Future<FestivalGuest> festivalGuest = _db.getFestivalGuest(user);

    // Define local variable to tjans
    Future<List<Tjans>> guestTjanser;

    return FutureBuilder<FestivalGuest>(
      future: festivalGuest,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Show a loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if something went wrong
        } else {
          // Get the user email
          String guestEmail = snapshot.data!.eMail;

          // Make a HTTP request to the backend to get the user
          try {
            guestTjanser = _http_provider.getGuestTjanser(guestEmail);
          } catch (e) {
            // Handle the exception and return a default value
            rethrow;
          }

          return Scaffold(
            appBar: StandardAppBar(),
            body: FutureBuilder<List<Tjans>>(
              future: guestTjanser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator()); // Show a loading spinner while waiting
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Show error message if something went wrong
                } else {
                  return Column(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) => Expanded(
                        flex: 1,
                        child: TjansTile(
                          tjanseNavn: snapshot.data![index].tjanseNavn,
                          tjanseKortBeskrivelse: snapshot.data![index].tjanseKortBeskrivelse,
                          tjanseLangBeskrivelse: snapshot.data![index].tjanseLangBeskrivelse,
                          tjanseTidspunkt: snapshot.data![index].tjanseTidspunkt,
                          tjansePlacering: snapshot.data![index].tjansePlacering,
                          route: '/tjanser',
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}

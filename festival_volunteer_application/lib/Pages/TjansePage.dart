import 'package:festival_volunteer_application/Utility/UserHandler.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/TjansTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:festival_volunteer_application/Services/AuthService.dart';

class TjansePage extends StatefulWidget {
  const TjansePage({Key? key}) : super(key: key);

  @override
  _TjansePageState createState() => _TjansePageState();
}

class _TjansePageState extends State<TjansePage> {
  late final _db = DBProvider();

  @override
  Widget build(BuildContext context) {
    // Get the authenticated user
    // Get the user from the DB
    List<Future<Tjans>> tjanser = UserHandler().user!.tjanser;

    // Define local variable to tjans
    Future<List<Tjans>> guestTjanser;

    return Column(
      children: List.generate(tjanser.length,
              (index) {
                return Expanded(flex: 1, child: FutureBuilder(future: tjanser[index],
                    builder: (BuildContext context, AsyncSnapshot<Tjans> snapshot) {
                      if(!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        Tjans tjans = snapshot.requireData;
                        return TjansTile(
                            tjanseNavn: tjans.name,
                            tjanseKortBeskrivelse: tjans.shortDescription,
                            tjanseLangBeskrivelse: {},
                            tjansePlacering: tjans.location,
                            tjanseTidspunkt: tjans.time.toString(),
                            route: "/tjanser");
                      }
                    }
                ));
              }),
    );

  }
}

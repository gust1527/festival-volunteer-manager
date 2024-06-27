import 'package:festival_volunteer_application/Providers/gcal_provider.dart';
import 'package:festival_volunteer_application/Utility/UserHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/AuthService.dart';
import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
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
  final _gcalProvider = GCALProvider();
  User? user;
  late Future<List<calendar.Event>> _relevantEvents;
  late Future<List<calendar.Event>> _musicEvents;
  late Future<Tjans> guestTjans;

  @override
  void initState() {
    super.initState();

    AuthService().userStream.listen((event) {
      setState(() {
        user = event;
        if (user != null) {
          // Get the first tjans from the user
          guestTjans = UserHandler().user!.tjanser[0];

          // Initialize calendar events fetching
          _relevantEvents = _gcalProvider.getFutureEvents('8e87aa9e93550d69001740ad7e4d8a7f85e7ded096626424c8494a8da9e7ea68@group.calendar.google.com');
          _musicEvents = _gcalProvider.getFutureEvents('o8et2jfhroob27aoa5op6dud2k@group.calendar.google.com');
        }
      });
    });
  }

  @override
  void dispose() {
    _gcalProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                FutureBuilder<Tjans>(
                  future: guestTjans,
                  builder: (BuildContext context, AsyncSnapshot<Tjans> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      DateTime dateTime = snapshot.requireData.time.toDate();
                      String formattedTime = DateFormat('EEEE d. MMMM @ HH:mm', 'da_DK').format(dateTime);
                      return Expanded(
                          flex: 1,
                          child: ExpandedDialogTile(
                            title: 'Din tjans',
                            content: 'Du har fået tjansen "${snapshot.requireData.name}", som indebærer at "${snapshot.requireData.shortDescription}". Du skal møde til tjansen "$formattedTime"',
                            route: '/tjanser',
                          ));
                    }
                  },
                ),
                FutureBuilder<List<calendar.Event>>(
                  future: _relevantEvents,
                  builder: (BuildContext context, AsyncSnapshot<List<calendar.Event>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Expanded(
                          flex: 1,
                          child: ExpandedDialogTile(
                            title: 'Relevant information',
                            content: snapshot.data!.isNotEmpty ? 'Næste begivenhed: ${snapshot.data!.first.summary}' : 'Ingen kommend begivenheder',
                            route: '/information',
                          ));
                    }
                  },
                ),
                FutureBuilder<List<calendar.Event>>(
                  future: _musicEvents,
                  builder: (BuildContext context, AsyncSnapshot<List<calendar.Event>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Expanded(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                              child: ExpandedDialogTile(
                            title: 'Musik program',
                            content: snapshot.data!.isNotEmpty ? 'Næste artist: ${snapshot.data!.first.summary}' : 'Ingen kommende artister',
                            route: '/music',
                          )),
                          Expanded(
                              child: ExpandedDialogTile(
                            title: 'Madboder',
                            content: 'Du har fået tjansen , som indebærer . Du skal møde til tjansen kl ',
                            route: '/foodAndBeverages',
                          )),
                        ],
                      ));
                    }
                  },
                ),
              ],
            ),
    );
  }
}

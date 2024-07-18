import 'package:festival_volunteer_application/Providers/gcal_provider.dart';
import 'package:festival_volunteer_application/Utility/GlobalHandler.dart';
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
  Future<List<calendar.Event>>? _relevantEvents;
  Future<List<calendar.Event>>? _musicEvents;
  Future<Tjans>? guestTjans;

  @override
  void initState() {
    super.initState();

    AuthService().userStream.listen((event) {
      setState(() {
        user = event;
        if (user != null) {
          // Get the first tjans from the user
          guestTjans = GlobalHandler().user!.tjanser[0];

          // Initialize calendar events fetching
          _initializeCalendarEvents();
        }
      });
    });
  }

  Future<void> _initializeCalendarEvents() async {
    setState(() {
      _relevantEvents = _gcalProvider.getFutureEvents(
          '8e87aa9e93550d69001740ad7e4d8a7f85e7ded096626424c8494a8da9e7ea68@group.calendar.google.com');
      _musicEvents = _gcalProvider.getFutureEvents(
          'o8et2jfhroob27aoa5op6dud2k@group.calendar.google.com');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_backdrop_V1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: user == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  FutureBuilder<Tjans>(
                    future: guestTjans,
                    builder:
                        (BuildContext context, AsyncSnapshot<Tjans> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.requireData.name.isEmpty || snapshot.requireData.name == 'Ingen tjans' || snapshot.requireData.shortDescription == 'Ingen tjans endnu' || snapshot.requireData.location == 'Derhjemme' || snapshot.requireData.shortDescription.isEmpty) {
                        // If placeholder tjans is retrieved, then do not show anything
                        return SizedBox.shrink();
                      } else {
                        try {
                          DateTime dateTime = snapshot.requireData.time.toDate();
                          String formattedTime =
                              DateFormat('EEEE d. MMMM @ HH:mm', 'da_DK')
                                  .format(dateTime);
                          return Expanded(
                              flex: 1,
                              child: ExpandedDialogTile(
                                title: 'Din tjans',
                                content:
                                    'Du har fået tjansen "${snapshot.requireData.name}", som indebærer at "${snapshot.requireData.shortDescription}". Du skal møde til tjansen "$formattedTime"',
                                route: '/tjanser',
                              ));
                        } catch (e) {
                          return const Center(child: Text('Error loading tjans'));
                        }
                      }
                    },
                  ),
                  FutureBuilder<List<calendar.Event>>(
                    future: _musicEvents,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<calendar.Event>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Text(
                                'No calendar data found for activities events: ${snapshot.error}'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        try {
                          // Fetch the first event from the list
                          calendar.Event firstMusicEvent = snapshot.data!.first;
        
                          // Fetch the start time of the first event
                          DateTime startTime =
                              firstMusicEvent.start?.dateTime?.toLocal() ??
                                  DateTime.now();
                          String formattedTime =
                              DateFormat('HH:mm').format(startTime);
        
                          // Fetch the summary of the first event
                          String summary = firstMusicEvent.summary ??
                              'Ingen kommende artister';
        
                          return Expanded(
                            flex: 1,
                            child: ExpandedDialogTile(
                              title: 'Musik program',
                              content: snapshot.data!.isNotEmpty
                                  ? 'Næste artist: ${summary} kl. ${formattedTime}'
                                  : 'Ingen kommende artister',
                              route: '/music',
                            ),
                          );
                        } catch (e) {
                          return const Center(
                              child: Text('Error loading relevant information'));
                        }
                      }
                    },
                  ),
                  FutureBuilder<List<calendar.Event>>(
                    future: _relevantEvents,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<calendar.Event>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Text(
                                'No calendar data found for music events: ${snapshot.error}'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        try {
                          // Fetch the first event from the list
                          calendar.Event firstEvent = snapshot.data!.first;
        
                          // Fetch the start time of the first event
                          DateTime startTime =
                              firstEvent.start?.dateTime?.toLocal() ??
                                  DateTime.now();
                          String formattedTime =
                              DateFormat('HH:mm').format(startTime);
        
                          // Fetch the summary of the first event
                          String summary = firstEvent.summary ?? 'Ingen kommende begivenheder';
                          
                          return Expanded(
                              child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: ExpandedDialogTile(
                                title: 'Begivenheder',
                                content: snapshot.data!.isNotEmpty
                                    ? '$summary kl. $formattedTime'
                                    : 'Ingen kommende begivenheder',
                                route: '/information',
                              )),
                              const Expanded(
                                  child: ExpandedDialogTile(
                                title: 'Mad og drikke',
                                content: 'Få noget i skrutten!',
                                route: '/foodAndBeverages',
                              )),
                            ],
                          ));
                        } catch (e) {
                          return const Center(
                              child: Text('Error loading music program'));
                        }
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

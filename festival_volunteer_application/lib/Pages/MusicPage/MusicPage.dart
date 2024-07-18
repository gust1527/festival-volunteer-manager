import 'package:festival_volunteer_application/Pages/MusicPage/Artists.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:festival_volunteer_application/Providers/gcal_provider.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';

class MusicPage extends StatefulWidget {
  int dateSelected = 0;
  MusicPage({super.key});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  late Future<List<calendar.Event>> _futureEvents;
  final String calendarId = 'o8et2jfhroob27aoa5op6dud2k@group.calendar.google.com';

  @override
  void initState() {
    super.initState();
    _futureEvents = GCALProvider().getFutureEvents(calendarId);
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
        child: FutureBuilder<List<calendar.Event>>(
          future: _futureEvents,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Fejl: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Ingen artister fundet'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Event event = snapshot.data![index];
                  DateTime startTime = event.start?.dateTime?.toLocal() ?? DateTime.now();
                  // Fetch the start time of the first event
                  String formattedTime = DateFormat('HH:mm').format(startTime);
                  var artistName = event.summary ?? 'Intet artistnavn fundet';
                  Artist artist = Artist(name: artistName, time: startTime);
        
                  return ArtistWidget(artist);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

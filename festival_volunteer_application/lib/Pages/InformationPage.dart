import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:festival_volunteer_application/Providers/gcal_provider.dart';
import 'package:intl/intl.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  late Future<List<calendar.Event>> _futureEvents;
  final String calendarId = '8e87aa9e93550d69001740ad7e4d8a7f85e7ded096626424c8494a8da9e7ea68@group.calendar.google.com';

  @override
  void initState() {
    super.initState();
    _futureEvents = GCALProvider().getFutureEvents(calendarId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: FutureBuilder<List<calendar.Event>>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Fejl: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Ingen begivenheder fundet'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var event = snapshot.data![index];
                var startTime = event.start?.dateTime?.toLocal() ?? DateTime.now();
                // Fetch the start time of the event
                String formattedTime = DateFormat('HH:mm').format(startTime);

                var eventSummary = event.summary ?? 'Intet begivenhedsnavn fundet';

                return ListTile(
                  title: Text(eventSummary),
                  subtitle: Text('Næste begivenhed: $eventSummary @ $formattedTime'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

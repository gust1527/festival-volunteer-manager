import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final String calendarId =
      '8e87aa9e93550d69001740ad7e4d8a7f85e7ded096626424c8494a8da9e7ea68@group.calendar.google.com';
  late String formattedTime;

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
            // Check if the future is still loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Check if the future has an error
              return Center(child: Text('Fejl: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Check if the future has no data
              return const Center(child: Text('Ingen begivenheder fundet'));
            } else {
              // If the future has data
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var event = snapshot.data![index];
                  var startTime =
                      event.start?.dateTime?.toLocal() ?? DateTime.now();
                  // Fetch the start time of the event
                  String formattedTime = _getFormattedTime(startTime);

                  // Fetch the summary of the event
                  String eventSummary =
                      event.summary ?? 'Intet begivenhedsnavn fundet';

                  // Get the event description
                  String eventDescription =
                      event.description ?? 'Ingen beskrivelse';

                  // Return a ListTile with the event summary, description, and the formatted time
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Color.fromARGB(255, 210, 232, 198)?.withOpacity(
                        0.85), // Set the color to be somewhat transparent
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Add padding here
                      child: ListTile(
                        title: Text(
                          '$eventSummary, $formattedTime',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OedstedFestival',
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (eventDescription.isNotEmpty)
                              Text(
                                eventDescription,
                              ),
                          ],
                        ),
                        minVerticalPadding: 0,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

String _getFormattedTime(DateTime artistTime) {
  // Extract weekday from DateTime object
  String convertedTime = DateFormat('EEEE HH:mm', 'da_DK').format(artistTime);

  // Capitalize the first letter
  convertedTime =
      convertedTime.substring(0, 1).toUpperCase() + convertedTime.substring(1);

  // Return the first three letters of the weekday
  return convertedTime;
}

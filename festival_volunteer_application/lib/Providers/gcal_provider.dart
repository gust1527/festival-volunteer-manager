import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:http/http.dart' as http;

class GCALProvider {
  final String apiKey;

  GCALProvider() : apiKey = dotenv.env['GOOGLE_API_KEY']!;

  Future<List<calendar.Event>> getFutureEvents(String calendarId) async {
    var now = DateTime.now().toUtc();
    var url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?timeMin=${now.toIso8601String()}&singleEvents=true&orderBy=startTime&key=$apiKey');

    var response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load events');
    }

    var data = json.decode(response.body);
    var eventList = calendar.Events.fromJson(data);

    print(eventList.items);

    return eventList.items ?? [];
  }
}

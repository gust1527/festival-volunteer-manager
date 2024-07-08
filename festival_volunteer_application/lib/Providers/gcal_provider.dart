import 'dart:convert';
<<<<<<< HEAD
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class GCALProvider {
  final _scopes = [calendar.CalendarApi.calendarReadonlyScope];
  late ServiceAccountCredentials _credentials;
  AuthClient? _client;

  GCALProvider();

  Future<void> loadCredentials() async {
    // Load the service account credentials from the JSON file
    String jsonString = await rootBundle.loadString('oedsted-festival-app-74186dc80a46.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _credentials = ServiceAccountCredentials.fromJson(jsonMap);
    await _authenticate();
  }

  Future<void> _authenticate() async {
    _client = await clientViaServiceAccount(_credentials, _scopes);
  }

  Future<List<calendar.Event>> getFutureEvents(String calendarId) async {
    if (_client == null) {
      throw Exception("Client not authenticated");
    }

    var calendarApi = calendar.CalendarApi(_client!);
    var now = DateTime.now().toUtc();
    var eventList = await calendarApi.events.list(
      calendarId,
      timeMin: now,
      singleEvents: true,
      orderBy: 'startTime',
    );
=======
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:http/http.dart' as http;

class GCALProvider {
  final String apiKey;

  GCALProvider() : apiKey = 'AIzaSyAzDqolb5p9WWThSeTnfET8LI6pEttpxd4';

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
>>>>>>> main

    print(eventList.items);

    return eventList.items ?? [];
<<<<<<< HEAD
  }

  void close() {
    _client?.close();
=======
>>>>>>> main
  }
}

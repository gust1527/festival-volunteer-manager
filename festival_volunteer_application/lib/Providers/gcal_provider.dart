import 'dart:convert';
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

    print(eventList.items);

    return eventList.items ?? [];
  }

  void close() {
    _client?.close();
  }
}

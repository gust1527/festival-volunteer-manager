import 'package:http/http.dart' as http;
import 'dart:convert';

class GCAlProvider {
  final String calendarId;
  final String apiKey = 'AIzaSyAYS_kznd1yFBiwMQjwDgszNZXysyWMpjg';

  GCAlProvider({required this.calendarId});

  Future<List<dynamic>> getCalendarEvents() async {
    final url =
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['items'];
    } else {
      throw Exception('Failed to load calendar events: ${response.statusCode}');
    }
  }
}

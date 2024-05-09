import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:http/http.dart' as http;

class HttpProvider {
  Future<Tjans> getGuestTjans(email) async {
    // Make an HTTP GET request
    final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbx-VBRXZZV1uZmbmJU9Q_C5lUOYseYcuhpiIDQgQafVpjR915MAgWOjb73dERdcxhbW/exec?email=$email'));

    // Convert it to tjans
    Tjans tjans = Tjans.fromJson(response.body);
    // Return the HTTP response
    return tjans;
  }
}
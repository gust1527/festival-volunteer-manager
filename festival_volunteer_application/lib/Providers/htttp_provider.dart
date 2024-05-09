import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:http/http.dart' as http;

class HttpProvider {
  String urlEndPoint = 'https://script.google.com/macros/s/AKfycbx1e8DuefmE_OVukoi3uis_nrxy3VojLc8y_YbotGfPDL5MF9ZUgNg_WUgZMj5Nff3q/exec?email=';

  Future<Tjans> getGuestTjans(email) async {
    // Make an HTTP GET request
    final response = await http.get(Uri.parse(urlEndPoint + email));

    // Convert it to tjans
    Tjans tjans = Tjans.fromJson(response.body);
    // Return the HTTP response
    return tjans;
  }
}
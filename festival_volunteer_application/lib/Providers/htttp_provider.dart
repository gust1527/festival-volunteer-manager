import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpProvider {
  String urlEndPoint = 'https://script.google.com/macros/s/AKfycbzEpLCHdcjMmnzy3Jz_9vKOcWCygQVSpTVrzwuWuNsppvk4uqC5njOnJK_JmoKWysZ3/exec?email=';

  Future<List<Tjans>> getGuestTjanser(email) async {
    // Make an HTTP GET request
    final response = await http.get(Uri.parse(urlEndPoint + email));

    final List<dynamic> jsonList = jsonDecode(response.body);
    List<Tjans> tjanser = [];

    // Iterate over each JSON object and create a Tjans object
    for (var jsonObj in jsonList) {
      Tjans tjans = Tjans(
        navn: jsonObj['navn'],
        email: jsonObj['email'],
        tjanseNavn: jsonObj['tjanse_navn'],
        tjanseKortBeskrivelse: jsonObj['tjanse_kort_beskrivelse'],
        tjansePlacering: jsonObj['tjanse_placering'],
        tjanseTidspunkt: jsonObj['tjanse_tidspunkt'],
        tjanseLangBeskrivelse: jsonObj['tjanse_lang_beskrivelse'],
      );
      tjanser.add(tjans);
    }

    tjanser.forEach((element) { element.printTjans(); });

    // Return the list of Tjans objects
    return tjanser;
  }
}

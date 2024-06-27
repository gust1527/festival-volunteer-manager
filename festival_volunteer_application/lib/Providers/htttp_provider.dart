import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utility/HttpHandler.dart';

class HttpProvider implements HttpHandler {
  String urlEndPointShort = 'https://script.google.com/macros/s/AKfycbyNB-DkDjxzW5ee3VP85_Yi5hiQq6mD_6264KOeUya4zBwJXF9pJ1BehXSeYNPwfCP4/exec?email=';
  String urlEndPointLong = 'https://script.google.com/macros/s/AKfycbwHsfdFZa6zHPoa_jxm9C1EcJxBx3VXn1xo3yXA3M68XMIP78kWlMIQIt_w2uDrdOFw/exec?email=';

  late List<Tjans> tjanser;



  Future<List<Tjans>> getGuestTjanser(email) async {
    // Make an HTTP GET request
    final response = await http.get(Uri.parse(urlEndPointShort + email));

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
        tjanseLangBeskrivelse: Future.value({}),
      );
      tjanser.add(tjans);
    }

    tjanser.forEach((element) { element.printTjans(); });

    // Return the list of Tjans objects
    return tjanser;
  }

  @override
  // TODO: implement hurtigTjanseInfo
  Future<List<Tjans>> hurtigTjanseInfo(String email) async{
    final response = await http.get(Uri.parse(urlEndPointShort + email));

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
        tjanseLangBeskrivelse: Future.value({"ingen tjans": ""})
      );
      tjanser.add(tjans);
    }

    tjanser.forEach((element) { element.printTjans(); });

    // Return the list of Tjans objects
    return tjanser;
  }

  @override
  Future<void> updateTjansWithLangBeskrivelse(String email) async {
    int noOfTjanser = tjanser.length;

    final response = await http.get(Uri.parse(urlEndPointLong + email));

    final List<Map<String, dynamic>> jsonList = jsonDecode(response.body);

    int lengtOfJSONList = jsonList.length;

    // Iterate over each JSON object and create a Tjans object
    for (int i = 0; i < lengtOfJSONList; i++) {
      tjanser[i].tjanseLangBeskrivelse = jsonList[i]["tjanse_lang_beskrivelse"];


    }
  }
}

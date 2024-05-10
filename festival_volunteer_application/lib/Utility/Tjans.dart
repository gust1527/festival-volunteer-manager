import 'dart:convert';

class Tjans {
  final String email;
  final String navn;
  final String tjanseNavn;
  final String tjanseKortBeskrivelse;
  final Map<String, dynamic> tjanseLangBeskrivelse;
  final String tjansePlacering;
  final String tjanseTidspunkt;

  Tjans({
    required this.email,
    required this.navn,
    required this.tjanseNavn,
    required this.tjanseKortBeskrivelse,
    required this.tjansePlacering,
    required this.tjanseTidspunkt,
    required this.tjanseLangBeskrivelse,
  });

  factory Tjans.fromJson(dynamic json) {
    try {
      json = jsonDecode(json);
    } catch (e) {
      throw Exception('Failed to decode JSON');
    }

    return Tjans(
      email: json.keys.first,
        navn: List<String>.from(json.values.first['navn'])[0],
        tjanseNavn: List<String>.from(json.values.first['tjanse_navn'])[0],
        tjanseKortBeskrivelse:
          List<String>.from(json.values.first['tjanse_beskrivelse'])[0],
        tjansePlacering:
          List<String>.from(json.values.first['tjanse-placering'])[0],
        tjanseTidspunkt:
          List<String>.from(json.values.first['tjanse_tidspunkt'])[0],
        tjanseLangBeskrivelse: json.values.first['tjanse_lang_beskrivelse'],
    );
  }

  void printTjans() {
    print('Tjans: $tjanseNavn');
    print('Beskrivelse: $tjanseKortBeskrivelse');
    print('Placering: $tjansePlacering');
    print('Tidspunkt: $tjanseTidspunkt');
    print('Lang beskrivelse: $tjanseLangBeskrivelse');
  }
}

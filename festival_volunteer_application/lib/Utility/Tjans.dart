import 'dart:convert';

class Tjans {
  final String email;
  final List<String> navn;
  final List<String> tjanseNavn;
  final List<String> tjanseBeskrivelse;
  final List<String> tjansePlacering;
  final List<String> tjanseTidspunkt;

  Tjans({
    required this.email,
    required this.navn,
    required this.tjanseNavn,
    required this.tjanseBeskrivelse,
    required this.tjansePlacering,
    required this.tjanseTidspunkt,
  });

  factory Tjans.fromJson(dynamic json) {
    try {
      json = jsonDecode(json);
    } catch (e) {
      throw Exception('Failed to decode JSON');
    }

    return Tjans(
      email: json.keys.first,
      navn: List<String>.from(json.values.first['navn']),
      tjanseNavn: List<String>.from(json.values.first['tjanse_navn']),
      tjanseBeskrivelse:
          List<String>.from(json.values.first['tjanse_beskrivelse']),
      tjansePlacering:
          List<String>.from(json.values.first['tjanse-placering']),
      tjanseTidspunkt:
          List<String>.from(json.values.first['tjanse_tidspunkt']),
    );
  }
}

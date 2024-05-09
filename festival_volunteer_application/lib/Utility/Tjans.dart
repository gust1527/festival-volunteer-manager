class Tjans {
  final String tjanseName;
  final String tjanseDescription;
  final String tjanseLocation;
  final DateTime tjanseDate;

  Tjans({
    required this.tjanseName,
    required this.tjanseDescription,
    required this.tjanseLocation,
    required this.tjanseDate,
  });

  factory Tjans.fromJson(dynamic json) {
    return Tjans(
      tjanseName: json['tjanseName'],
      tjanseDescription: json['tjanseDescription'],
      tjanseLocation: json['tjanseLocation'],
      tjanseDate: json['tjanseDate'],
    );
  } 
}
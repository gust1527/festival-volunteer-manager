import 'dart:core';
import 'package:festival_volunteer_application/Utility/Tjans.dart';

class FestivalGuest {
    final String id;
    final String eMail;
    final String firstName;
    final Future<List<Tjans>> tjans;
    final int orderID;

    FestivalGuest({
  required this.id,
  required this.eMail,
  required this.firstName,
  required this.tjans,
  required this.orderID,
  });

  factory FestivalGuest.fromJson(Map<String, dynamic> json) {
    return FestivalGuest(
      id: json['id'],
      eMail: json['email'],
      firstName: json['first_name'],
      tjans: json['tjans'],
      orderID: json['order_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': eMail,
      'first_name': firstName,
      'tjans': tjans,
      'order_id': orderID,
    };
  }
}




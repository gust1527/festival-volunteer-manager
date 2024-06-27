import 'dart:core';
import 'package:festival_volunteer_application/Utility/Tjans.dart';

class FestivalGuest {
    final String eMail;
    final String firstName;
    final List<Future<Tjans>> tjanser;
    final int orderID;

    FestivalGuest({
  required this.eMail,
  required this.firstName,
  required this.tjanser,
  required this.orderID,
  });



  factory FestivalGuest.fromJson(Map<String, dynamic> json) {
    return FestivalGuest(
      eMail: json['email'],
      firstName: json['first_name'],
      tjanser: json['tjans'],
      orderID: json['order_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': eMail,
      'first_name': firstName,
      'tjans': tjanser,
      'order_id': orderID,
    };
  }
}




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/Interfaces/db_provider_interface.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../Utility/Tjans.dart';
import '../Utility/TjansLangBeskrivelse.dart';

class DBProvider with ChangeNotifier implements DBProviderInterface {
  // Get Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  @override
  Future<FestivalGuest> getFestivalGuest(User user) async {
    String email = user.email!;
    try {
      // Get the festivalGuests collection from the Firestore database
      final snapshot = await _db.collection('festival_guests').doc(email).get();

      // Check if the document was found
      if (snapshot.exists) {
        // Extract data from the document
        final docData = snapshot.data()!;
        print("HER1${docData['tjanser'].toString()}");
        // Fetch details for all tjanser
        (docData['tjanser'] as List).forEach((element) {print("path is ${element.path}");});
        final List<Future<Tjans>> tjanser =
            (docData['tjanser'] as List).map((tjansPath) => _getTjansDetails(tjansPath.path)).toList();
        print("HER2${tjanser}");

        final festivalGuest = FestivalGuest(
          eMail: email,
          firstName: docData['full_name'],
          tjanser: tjanser, // Fetching details for the first tjanse
          orderID: docData['order_id'],
        );
        return festivalGuest;
      } else {
        throw Exception('No festival guest found for the user');
      }
    } catch (error) {
      throw Exception('Could not get festival guest: $error');
    }
  }

// Helper function to get Tjans details
  Future<Tjans> _getTjansDetails(dynamic tjansPath) async {
    final tjansDoc = await _db.doc(tjansPath).get();
    if (tjansDoc.exists) {
      final tjansData = tjansDoc.data()!;
      return Tjans(
          tjansData['name'],
          DateTime.parse(tjansData['time']),
          tjansData['location'],
          tjansData['short_description'],
          TjansLangBeskrivelse(tjansData['long_description']) // Assuming long_description is stored as a path
      );
    } else {
      throw Exception('Tjans details not found');
    }
  }
  @override
  Future<void> linkFestivalGuestWithTicket(String orderID, String userId) {
    try {
      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc(userId).update({
        'order_id': orderID,
      }).then((value) {
        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<FestivalGuest> createNewFestivalGuest(String id, String email, String name) {
    // TODO: implement createNewFestivalGuest
    throw UnimplementedError();
  }
}

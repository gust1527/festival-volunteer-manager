import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/Interfaces/db_provider_interface.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:flutter/foundation.dart';

class db_provider with ChangeNotifier implements DBProviderInterface {
  // Get Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<FestivalGuest> getFestivalGuest(String id) {
    try {

      // Print the id of the festivalGuest
      print(id);

      // Print the collection of festivalGuests
      print(_db.collection('festival_guests'));

      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc(id).get().then((doc) {
        // If the document exists, return the festivalGuest object
        print(doc.data());

        if (doc.exists) {
          return FestivalGuest.fromJson(doc.data() as Map<String, dynamic>);
        } else {
          // If the document does not exist, throw an error
          throw Exception('FestivalGuest not found');
        }
      });

    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> linkFestivalGuestWithTicket(int orderID, int userId) {
    try {
      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc('id').update({
        'orderID': orderID,
      }).then((value) {
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }
  
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/Interfaces/db_provider_interface.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:flutter/foundation.dart';

class DBProvider with ChangeNotifier implements DBProviderInterface {
  // Get Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<FestivalGuest> getFestivalGuest(String id) {
    try {
      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc(id).get().then((doc) {
        // named boolean variable to check if the document exists
        final bool docExists = doc.exists;

        if (docExists) {
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
  Future<void> linkFestivalGuestWithTicket(String orderID, String userId) {
    try {
      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc(userId).update({
        'order_id': orderID,
      }).then((value) {
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<bool> hasTjans(String userID) {
    try {
      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc(userID).get().then((doc) {
        // named boolean variable to check if the document exists
        final bool docExists = doc.exists;
        if (docExists) {
          return doc.data()!['tjans'] != null;
        } else {
          // If the document does not exist, throw an error
          throw Exception('Tjans for user not found');
        }
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> getTjans(String userID) {
    try {
      // Get the festivalGuest collection from the firestore database
      return _db.collection('festival_guests').doc(userID).get().then((doc) {
        // named boolean variable to check if the document exists
        final bool docExists = doc.exists;
        if (docExists) {
          return doc.data()!['tjans'];
        } else {
          // If the document does not exist, throw an error
          throw Exception('Tjans for user not found');
        }
      });
    } catch (error) {
      throw error;
    }
  }
}

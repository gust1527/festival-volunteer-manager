import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/Interfaces/db_provider_interface.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DBProvider with ChangeNotifier implements DBProviderInterface {
  // Get Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<FestivalGuest> getFestivalGuest(User? user) async {
    try {
      // Get the festivalGuest collection from the firestore database
      final snapshot = await _db.collection('festival_guests').where('email', isEqualTo: user?.email).get();
      
      // Check if any documents were found
      if (snapshot.docs.isNotEmpty) {
        // Get the first document from the snapshot
        final doc = snapshot.docs.first;

        print(doc.data());
        // Create a new FestivalGuest object from the document
        final FestivalGuest festivalGuest = FestivalGuest(
          id: doc.data()['id'],
          eMail: doc.data()['email'],
          firstName: doc.data()['first_name'],
          tjans: doc.data()['tjans'],
          orderID: doc.data()['order_id'],
        );
        return festivalGuest;
      } else {
        throw Exception('No festival guest found for the user');
      }
    } catch (error) {
      throw Exception('Could not get festival guest: $error');
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
      rethrow;
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
      rethrow;
    }
  }
  
  @override
  Future<FestivalGuest> createNewFestivalGuest(String id, String email, String name) {
    // TODO: implement createNewFestivalGuest
    throw UnimplementedError();
  }
}

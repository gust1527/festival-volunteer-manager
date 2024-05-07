import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';

abstract class DBProviderInterface {

  Future<void> linkFestivalGuestWithTicket(String orderID, String userID);

  Future<bool> hasTjans(String userID);

  Future<String> getTjans(String userID);

  Future<FestivalGuest> getFestivalGuest(String id);
}
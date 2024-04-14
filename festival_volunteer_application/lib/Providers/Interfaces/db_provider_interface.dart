import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';

abstract class DBProviderInterface {
  
  Future<FestivalGuest> getFestivalGuest(String id);

  Future<void> linkFestivalGuestWithTicket(int orderID, int userID); 
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';

class Test {
  FirebaseFirestore _db = FirebaseFirestore.instance;


  void main() {
    shouldRetrieveProperTjans();
  }
  void beforeEach() {
  }



  bool shouldRetrieveProperTjans() {
    bool returnVal = true;
    dynamic snapshot = Future.wait([_db.collection('festival_guests').doc("test@test.dk").get()]);
    print(snapshot);
    return returnVal;
  }

  bool shouldRetrieveProperUser() {
    bool returnVal = true;
    return returnVal;
  }
}
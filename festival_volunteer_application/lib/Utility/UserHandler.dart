import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';

class UserHandler {

  FestivalGuest? user;
  static final UserHandler _instance = UserHandler._internal();
  UserHandler._internal();
  factory UserHandler() {
    return _instance;
  }

}
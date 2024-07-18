import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';

import '../Pages/MusicPage/Artists.dart';

class GlobalHandler {

  FestivalGuest? user;
  Artist? artist;
  static final GlobalHandler _instance = GlobalHandler._internal();
  GlobalHandler._internal();
  factory GlobalHandler() {
    return _instance;
  }

}
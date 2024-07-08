import 'package:festival_volunteer_application/Pages/FoodAndBeveragesPage.dart';
import 'package:festival_volunteer_application/Pages/HomeScreen.dart';
import 'package:festival_volunteer_application/Pages/LinkTicket.dart';
import 'package:festival_volunteer_application/Pages/LoginScreen.dart';
import 'package:festival_volunteer_application/Pages/MusicPage/MusicPage.dart';
import 'package:festival_volunteer_application/Pages/RegisterWithEmailAndOrderIdPage.dart';
import 'package:festival_volunteer_application/Pages/TjansePage.dart';
import 'package:festival_volunteer_application/Pages/InformationPage.dart';

var routes = {
    '/foodAndBeverages': (context) => const FoodAndBeveragesPage(),
    '/': (context) => const HomeScreen(),
    '/information': (context) => const InformationPage(),
    '/music': (context) => const MusicPage(),
    '/tjanser': (context) => const TjansePage(),
    '/login': (context) => LoginScreen(),
    '/link-ticket': (context) => LinkTicketPage(),
    '/register-non-google-user': (context) => RegisterWithEmailAndOrderIdPage(),
  };

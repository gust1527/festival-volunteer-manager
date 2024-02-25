import 'package:festival_volunteer_application/Pages/FoodAndBeveragesPage.dart';
import 'package:festival_volunteer_application/Pages/HomeScreen.dart';
import 'package:festival_volunteer_application/Pages/MusicPage.dart';
import 'package:festival_volunteer_application/Pages/TjansePage.dart';
import 'package:festival_volunteer_application/Pages/InformationPage.dart';
import 'package:flutter/material.dart';

var routes = {
    '/foodAndBeverages': (context) => FoodAndBeveragesPage(),
    '/': (context) => HomeScreen(),
    '/information': (context) => InformationPage(),
    '/music': (context) => MusicPage(),
    '/tjanser': (context) => const TjansePage(),
  };

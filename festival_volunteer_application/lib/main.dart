import 'package:festival_volunteer_application/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
 const MainApp({Key? key}) : super(key: key);
 
 @override
  _MainAppState createState() => _MainAppState(); 
  }
  
  class _MainAppState extends State<MainApp> {

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      ); 
    }
  }

import 'package:festival_volunteer_application/routes.dart';
import 'package:festival_volunteer_application/tests.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  initializeDateFormatting('da_DK');
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
        initialRoute: '/login',
        routes: routes,
      ); 
    }
  }
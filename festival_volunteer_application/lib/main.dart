import 'package:festival_volunteer_application/routes.dart';
import 'package:festival_volunteer_application/tests.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Pages/MusicPage/Artists.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        onGenerateRoute: onGenerateRoute,
      ); 
    }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name!);

    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'music') {
      final String artistName = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (context) => ArtistPage(),
        settings: settings,
      );
    }
    print(routes[settings.name]);
    return MaterialPageRoute(builder: routes[settings.name]!, settings: settings);
  }
}
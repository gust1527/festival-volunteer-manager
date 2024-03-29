import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StandardAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ExpandedDialogTile(
                title: 'Bartjans', content: 'Lørdag: 12:00 - 17:00', route: '/tjanser',),
          ),
          Expanded(
            flex: 1,
            child: ExpandedDialogTile(
                title: 'Relevant information', content: 'Volleyball kl. 12:00', route: '/information',),
          ), 
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget> [
                Expanded(
                  child: ExpandedDialogTile(
                      title: 'Musikprogram', content: 'Find ud af hvilken dag, der rykker mest for dig!', route: '/music'),
                ),
                Expanded(
                  child: ExpandedDialogTile(
                  title: "Madboder", content: "Få noget i mavsen!", route: '/foodAndBeverages')
                  ),
                  ],
            ),
            ),
        ],
      ),
    );
  }
}

import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/HalfWidthDialog.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ExpandedDialogTile(
                title: 'Bartjans', content: 'Lørdag: 12:00 - 17:00'),
          ),
          Expanded(
            flex: 1,
            child: ExpandedDialogTile(
                title: 'Relevant information', content: 'Volleyball kl. 12:00'),
          ), 
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                HalfWidthDialogTile(
                    title: 'Musikprogram', content: 'Find ud af hvilken dag, der rykker mest for dig!'),
                HalfWidthDialogTile(
                    title: 'Mad og drikke', content: 'Find ud af hvad du kan få at spise og drikke!'),
              ],
            ),
            ),
        ],
      ),
    );
  }
}

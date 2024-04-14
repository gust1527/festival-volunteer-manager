import 'package:festival_volunteer_application/UX_Elements/ExpandedDialogTile.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';

class TjansePage extends StatefulWidget {
  const TjansePage({super.key});

  @override
  _TjansePageState createState() => _TjansePageState();
}

class _TjansePageState extends State<TjansePage> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: StandardAppBar(),
            body: Column(
                children: <Widget>[
          Expanded(
            flex: 1,
            child: ExpandedDialogTile(
                title: Future.value('Fedt at du vil hjælpe til!!'), content: 'Velkommen til "Tjanse-siden"! Herunder vil du finde information omkring din tjans.', route: '/tjanser'),
          ),
          Expanded(
            flex: 1,
            child: ExpandedDialogTile(
                title: Future.value('(DIN VAGT)'), content: 'Du har fået tjansen (XXX), som indebærer (XXX). Du skal møde til tjansen kl (XXX)', route: '/tjanser'),
          ),      
                ], 
            ),
        );
    }
}
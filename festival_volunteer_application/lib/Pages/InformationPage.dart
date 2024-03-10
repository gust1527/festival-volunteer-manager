import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {

    @override
    Widget build(BuildContext context) {
        return const Scaffold(
            appBar: StandardAppBar(),
            body: Column()
        );
    }
}
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';

class FoodAndBeveragesPage extends StatefulWidget {
  const FoodAndBeveragesPage({super.key});

  @override
  _FoodAndBeveragesState createState() => _FoodAndBeveragesState();
}

class _FoodAndBeveragesState extends State<FoodAndBeveragesPage> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: StandardAppBar(),
            body: const Column(
            )
        );
    }
}
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';

class TjansDescriptionPage extends StatelessWidget {
  final Map<String, dynamic> jsonData;

  TjansDescriptionPage({Key? key, required this.jsonData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: ListView.builder(
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          String key = jsonData.keys.elementAt(index);
          dynamic value = jsonData[key];

          return ListTile(
            title: Text(
              key,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival' // Add your desired TextStyle properties here
              ),
            ),
            subtitle: buildDescription(value),
          );
        },
      ),
    );
  }

  Widget buildDescription(dynamic value) {
    if (value is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: value.map<Widget>((item) => Text(item)).toList(),
      );
    } else {
      return Text(value.toString());
    }
  }
}

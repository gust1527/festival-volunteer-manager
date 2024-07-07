import 'package:festival_volunteer_application/Utility/TjansLangBeskrivelse.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';

class TjansDescriptionPage extends StatelessWidget {
  late TjansLangBeskrivelse tjansLangBeskrivelse;

  TjansDescriptionPage({Key? key, required this.tjansLangBeskrivelse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Hvor skal du være henne:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseWhere)),
          ),
          ListTile(
            title: const Text(
              'Dette skal du bruge for at kunne udføre din tjans:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseSupplies)),
          ),
          ListTile(
            title: const Text(
              'Dette går din tjans ud på:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseWhat)),
          ),
          ListTile(
            title: const Text(
              'Hvornår er du færdig med din tjans:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseDoneWhen)),
          ),
          ListTile(
            title: const Text(
              'Her skal du aflevere udstyret når du er færdig:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseEquipmentReturn)),
          ),
          ListTile(
            title: const Text(
              'Specielle forhold ved præcis min tjans:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseSpecialInformation)),
          ),
          ListTile(
            title: const Text(
              'Hvem kan du henvende dig til hvis du har spørgsmål:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival', // Add your desired TextStyle properties here
              ),
            ),
            subtitle: Text(_convertToLineShift(tjansLangBeskrivelse.tjanseQuestionsLocation)),
          ),
        ],
      ),
    );
  }
}

String _convertToLineShift(String text) {
  return text.replaceAll(";", "\n").replaceAll("\\n", "\n");
}
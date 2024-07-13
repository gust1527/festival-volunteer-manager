import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:festival_volunteer_application/Utility/TjansLangBeskrivelse.dart';
import 'package:flutter/material.dart';
import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';

class TjansDescriptionPage extends StatelessWidget {
  final TjansLangBeskrivelse tjansLangBeskrivelse;
  final Tjans currentTjans;

  TjansDescriptionPage({Key? key, required this.tjansLangBeskrivelse, required this.currentTjans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = currentTjans.name; // Assuming 'name' is a property in Tjans class
    List<String> participants = currentTjans.participants; // Assuming 'participants' is a property in Tjans class

    return Scaffold(
      appBar: StandardAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_backdrop_V1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Card(
          color: Color.fromARGB(255, 210, 232, 198)?.withOpacity(0.85), // Set the color to be somewhat transparent
          shadowColor: Colors.black,
          margin: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
          child: ListView(
            children: [
              _buildHeader(name, participants),
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
        ),
      ),
    );
  }

  Widget _buildHeader(String name, List<String> participants) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name, // Replace with your desired header text format
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
            child: Text(
              'Deltagere: ${participants.join(", ")}', // Adjust as per your participants list format
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ), // Optional: Add a divider below the header
        ],
      ),
    );
  }

  String _convertToLineShift(String text) {
    return text.replaceAll(";", "\r").replaceAll("\\r", "\r");
  }
}

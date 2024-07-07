import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/UX_Elements/TjansDescriptionPage.dart';
import 'package:festival_volunteer_application/Utility/Tjans.dart';
import 'package:festival_volunteer_application/Utility/TjansLangBeskrivelse.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TjansTile extends StatelessWidget {
  final Tjans currentTjans;
  final String route;

  const TjansTile({
    Key? key,
    required this.currentTjans,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert the timestamp from Tjans to usable date format
    Timestamp dateTime = currentTjans.time;

    String formattedTime = DateFormat('EEEE d. MMMM @ HH:mm', 'da_DK').format(dateTime.toDate());

    return Card(
      color: Colors.grey[300],
      margin: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            // Get the long_description from the DB provider if the path is not empty
            if (currentTjans.longDescriptionPath.isNotEmpty) {
              DBProvider().getTjansLangBeskrivelse(currentTjans.longDescriptionPath).then((TjansLangBeskrivelse tjanseLangBeskrivelse) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TjansDescriptionPage(
                      tjansLangBeskrivelse: tjanseLangBeskrivelse,),
                  ),
                );
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Der er ingen beskrivelse til denne tjans'),
                  duration: Durations.long1,
                ),
              );
            }
          },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity, // Expand to the edge of the screen
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 8.0),
                child: Text(
                  currentTjans.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OedstedFestival',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Beskrivelse: ',
                        style: TextStyle(
                          fontFamily: 'OedstedFestival',
                        ),
                      ),
                      TextSpan(
                        text: currentTjans.shortDescription,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Placering: ',
                        style: TextStyle(
                          fontFamily: 'OedstedFestival',
                        ),
                      ),
                      TextSpan(
                        text: currentTjans.location,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Tidspunkt: ',
                        style: TextStyle(
                          fontFamily: 'OedstedFestival',
                        ),
                      ),
                      TextSpan(
                        text: formattedTime,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

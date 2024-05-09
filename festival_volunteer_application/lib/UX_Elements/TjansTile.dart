import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TjansTile extends StatelessWidget {
  final String tjanseNavn;
  final String tjanseBeskrivelse;
  final String tjansePlacering;
  final String tjanseTidspunkt;
  final String route;

  const TjansTile({
    Key? key,
    required this.tjanseNavn,
    required this.tjanseBeskrivelse,
    required this.tjansePlacering,
    required this.tjanseTidspunkt,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      margin: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => {
          Navigator.pushNamed(context, route)
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity, // Expand to the edge of the screen
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 8.0),
                child: Text(
                  tjanseNavn,
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
                        text: tjanseBeskrivelse,
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
                        text: tjansePlacering,
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
                        text: tjanseTidspunkt,
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

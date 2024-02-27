import 'package:flutter/material.dart';

class ExpandedDialogTile extends StatelessWidget {
  final String title;
  final String content;
  final String route;

  const ExpandedDialogTile(
      {super.key, required this.title, required this.content, required this.route});

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
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OedstedFestival'
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OedstedFestival'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity, // Expand to the edge of the screen
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  */
}

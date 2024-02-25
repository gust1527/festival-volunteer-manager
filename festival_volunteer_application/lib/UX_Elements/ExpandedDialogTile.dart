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
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
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

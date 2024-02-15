import 'package:flutter/material.dart';

class ExpandedDialogTile extends StatelessWidget {
  final String title;
  final String content;

  const ExpandedDialogTile({super.key, required this.title, required this.content});
  
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
}

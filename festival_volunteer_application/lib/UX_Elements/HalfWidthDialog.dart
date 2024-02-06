import 'package:flutter/material.dart';

class HalfWidthDialogTile extends StatelessWidget {
  final String title;
  final String content;

  HalfWidthDialogTile({super.key, required this.title, required this.content});
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Dialog(
        child: Container(
            padding: EdgeInsets.all(20),
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
        ),
    );
  }
}
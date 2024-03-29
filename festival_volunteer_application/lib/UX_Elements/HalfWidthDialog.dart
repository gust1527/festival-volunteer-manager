import 'package:flutter/material.dart';

class HalfWidthDialogTile extends StatelessWidget {
  final String title;
  final String content;

  const HalfWidthDialogTile({super.key, required this.title, required this.content});

 @override
 Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(20),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
     onTap: () => {}, 
     child: SizedBox(
       child: Column(
         children: [
              SizedBox( // Expand to the edge of the screen
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
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
  ),);
 }

  /*
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: dialog(
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
        ),
    );
  }
  */
}
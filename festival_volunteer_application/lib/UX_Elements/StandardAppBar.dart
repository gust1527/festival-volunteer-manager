import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StandardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: const Text('ØF 24!', style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF4C5E49),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            showAboutDialog(context: context, applicationName: 'ØF 24!', applicationVersion: '1.1.0', applicationIcon: const Icon(Icons.person), children: const <Widget>[
              Text('This is the ØF 24! app, a tool for the ØF 24! team to manage their daily tasks and keep track of their progress.'),
            ]);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
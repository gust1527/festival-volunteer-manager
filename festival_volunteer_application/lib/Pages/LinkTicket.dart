import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Services/AuthService.dart';
import 'package:flutter/material.dart';

class LinkTicketPage extends StatelessWidget {
  LinkTicketPage({super.key});
  String orderID = '';
  String userId = AuthService().user!.uid;

  final dbProvider = DBProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Link din billet',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'OedstedFestival',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Indtast dit ordre ID for at linke din billet til din konto.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) => orderID = value.trim(),
              decoration: const InputDecoration(
                hintText: 'Ordre ID',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                dbProvider.linkFestivalGuestWithTicket(orderID, userId);
                Navigator.pushNamed(context, '/');
              },
              child: Text('Bekræft'),
            ),
          ],
        ),
      ),
    );
  }
}

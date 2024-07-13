import 'package:festival_volunteer_application/Providers/db_provider.dart';
import 'package:festival_volunteer_application/Utility/FestivalGuest.dart';
import 'package:festival_volunteer_application/Utility/UserHandler.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithEmailAndOrderIdPage extends StatefulWidget {
  @override
  _RegisterWithEmailAndOrderIdPageState createState() =>
      _RegisterWithEmailAndOrderIdPageState();
}

class _RegisterWithEmailAndOrderIdPageState
    extends State<RegisterWithEmailAndOrderIdPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orderIdController = TextEditingController();
  final _db_provider = DBProvider();
  Stream<User?>? _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = _auth.authStateChanges();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _orderIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login for første gang', style: TextStyle(fontSize: 20, fontFamily: 'OedstedFestival', color: Colors.white)),
        backgroundColor: const Color(0xFF4C5E49),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_backdrop_V1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<User?>(
          stream: _userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              User? user = snapshot.data;
              if (user != null) {
                // User is already authenticated, navigate away
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _navigateToNextScreen(user);
                });
                return Center(child: CircularProgressIndicator());
              }
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 210, 232, 198).withOpacity(0.85),
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _orderIdController,
                    decoration: InputDecoration(
                      labelText: 'Order ID (Password)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(255, 210, 232, 198)?.withOpacity(0.85),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _registerWithEmailAndOrderId();
                    },
                    child: Text('Registrer dig'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFF4C5E49),
    );
  }

  void _registerWithEmailAndOrderId() async {
    try {
      String email = _emailController.text.trim();
      String orderId = _orderIdController.text.trim(); // Use orderId as the password

      // Create user with email and orderId (used as password)
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: orderId, // Use orderId as the password
      );

      // Navigate to home or another screen after successful registration
      _navigateToNextScreen(userCredential.user!);
    } catch (e) {
      // Handle registration errors
      print('Failed to register: $e');
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to register: $e'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  void _navigateToNextScreen(User user) {
    Future<FestivalGuest> festivalGuest = _db_provider.getFestivalGuest(user);
        festivalGuest.then((currentUserSnapshot) {
          UserHandler().user = currentUserSnapshot;
          // Get the order ID from the snapshot
          bool hasOrderID = currentUserSnapshot.orderID != 0;
          if (hasOrderID) {
            Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
          } else {
            Navigator.pushNamed(context, '/link-ticket');
          }
        });
  }
}

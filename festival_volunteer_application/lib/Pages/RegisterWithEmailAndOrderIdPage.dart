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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register with Email and Order ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _orderIdController,
              decoration: InputDecoration(
                labelText: 'Order ID (Password)',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _registerWithEmailAndOrderId();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
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
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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

  @override
  void dispose() {
    _emailController.dispose();
    _orderIdController.dispose();
    super.dispose();
  }
}

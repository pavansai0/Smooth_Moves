import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BuyerLoginScreen extends StatefulWidget {
  const BuyerLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BuyerLoginScreenState createState() => _BuyerLoginScreenState();
}

class _BuyerLoginScreenState extends State<BuyerLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('users');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _login() async {
    try {
      // ignore: unused_local_variable
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Perform any necessary actions after successful login
    } catch (error) {
      setState(() {
        _errorMessage = 'Login failed. Please check your credentials.';
      });
      debugPrint(error.toString());
    }
  }

  Future<void> _signup() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Store user data in Firebase Realtime Database
      final String uid = userCredential.user!.uid;
      final Map<String, dynamic> userData = {
        'email': _emailController.text.trim(),
        'role': 'buyer',
      };
      await _database.child(uid).set(userData);

      // Perform any necessary actions after successful signup
    } catch (error) {
      setState(() {
        _errorMessage = 'Signup failed. Please try again later.';
      });
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Signup'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

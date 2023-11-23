import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: usernameController.text,
      password: passwordController.text,
    );

    // Pass the user's email to the HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(userEmail: usernameController.text),
      ),
    );
  } catch (e) {
    // Handle login errors, e.g., display an error message
    print('Login error: $e');
  }
}


  void navigateToRegister() {
    // Navigate to the registration screen
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: navigateToRegister,
              child: Text(' Not register yet? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}

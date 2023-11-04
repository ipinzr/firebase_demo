import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'food.dart';
import 'drink.dart';
import 'menu.dart';
import 'firebase_options.dart'; // Import your Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Firebase is initialized before running the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/menu', // Define the initial route
      routes: {
        '/menu': (context) => MenuPage(),
        '/food': (context) => FoodPage(), // Define a named route for FoodPage
        '/drink': (context) => DrinkPage(), // Define a named route for DrinkPage
      },
    );
  }
}

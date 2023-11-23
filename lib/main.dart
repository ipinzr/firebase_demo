import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home.dart';
import 'package:firebase_demo/screen/login.dart';
import 'package:firebase_demo/screen/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/food.dart';
import 'screen/drink.dart';
import 'screen/menu.dart';
import 'screen/register.dart';
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
      initialRoute: '/register', // Define the initial route
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(userEmail: '',),
        '/menu': (context) => MenuPage(),
        '/food': (context) => FoodPage(), // Define a named route for FoodPage
        '/drink': (context) => DrinkPage(), // Define a named route for DrinkPage
        '/profile': (context) {
        final user = FirebaseAuth.instance.currentUser;
        return user != null ? UserProfileScreen(user: user) : LoginScreen();
        },
      },
    );
  }
}

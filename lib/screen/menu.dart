import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'food.dart';
import 'drink.dart';

class MenuItem {
  final String name;
  final String description;
  final double price;
  final bool isAvailable;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable, // Include the availability status
  });
}


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItem> foodMenu = [];
  List<MenuItem> drinkMenu = [];
  int _currentIndex = 0; // To track the selected tab

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    _loadMenuData();
  }

  Future<void> _loadMenuData() async {
    await _loadMenu('makanan', foodMenu);
    await _loadMenu('minuman', drinkMenu);
  }

  Future<void> _loadMenu(String collection, List<MenuItem> menu) async {
  final firestore = FirebaseFirestore.instance;
  firestore.collection(collection).snapshots().listen((snapshot) {
    final menuItems = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return MenuItem(
        name: data['field1'],
        description: data['field2'],
        price: data['price'], // You can add a price field in your Firestore data
        isAvailable: data['isAvailable'] ?? true, // Include the availability status
      );
    }).toList();

    setState(() {
      menu.clear();
      menu.addAll(menuItems);
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: _currentIndex == 0 ? _buildMenu(foodMenu) : _buildMenu(drinkMenu),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Makanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Minuman',
          ),
        ],
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
  // Get the current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Check if the current user is an admin
  bool isAdmin = currentUser?.email == 'admin@gmail.com';

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menu Options',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.restaurant_menu),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(userEmail: currentUser?.email ?? '')),
            );
          },
        ),
        if (isAdmin) // Show only if the user is an admin
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Food Menu'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodPage()),
              );
            },
          ),
        if (isAdmin) // Show only if the user is an admin
          ListTile(
            leading: Icon(Icons.local_drink),
            title: Text('Drink Menu'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrinkPage()),
              );
            },
          ),
      ],
    ),
  );
}


  Widget _buildMenu(List<MenuItem> menu) {
  // Filter out items that are not available
  final availableMenu = menu.where((item) => item.isAvailable).toList();

  return ListView.builder(
    itemCount: availableMenu.length,
    itemBuilder: (context, index) {
      final item = availableMenu[index];
      return Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Text('\$${item.price.toStringAsFixed(2)}'),
        ),
      );
    },
  );
}

}

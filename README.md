# Firebase Flutter CRUD implementation

ICT602 - MOBILE TECHNOLOGY AND DEVELOPMENT

Team member:
1
2
3
4

This Flutter app demonstrates a simple restaurant application with Firebase integration. It includes user authentication, menu management, and user profiles.

## Features

- User Authentication
  - Sign up and login with Firebase Authentication
  - Admin and normal user roles
- Menu Management
  - Display food and drink menu items
  - Admin-only access to menu management
- User Profile
  - Users can update their profiles
 
## CRUD Operations

The app includes basic CRUD (Create, Read, Update, Delete) operations. Here are snippets of the relevant code:

### Create Operation

Create user account
```dart
// Create a user with email and password using Firebase Authentication
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // Registration successful, show a snackbar
        final snackBar = SnackBar(
          content: Text('Registration successful. You can now log in.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // You can also navigate to the login screen
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Handle registration failure, if necessary
      }
    } catch (e) {
      // Handle registration errors, e.g., display an error message
      print('Registration error: $e');
    }
  }
```
Create food item
```dart
//create food item
  Future<void> _addDataToFirestore(String data, double price) async {
    try {
      await _firestore.collection('makanan').add({
        'field1': data,
        'field2': 'food',
        'isAvailable': true,
        'price': price, // Add the price to the document
      });
      _textFieldController.clear();
    } catch (e) {
      print('Error adding data: $e');
    }
  }
```
Create drink item
```dart
//create food item
  Future<void> _addDataToFirestore(String data, double price) async {
    try {
      await _firestore.collection('makanan').add({
        'field1': data,
        'field2': 'food',
        'isAvailable': true,
        'price': price, // Add the price to the document
      });
      _textFieldController.clear();
    } catch (e) {
      print('Error adding data: $e');
    }
  }
```

### Read Operation

read user data
```dart
void initState() {
    super.initState();
    // Fetch the user's profile data from Firestore
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(widget.user.uid).get();

      if (userDoc.exists) {
        final userProfile = userDoc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = userProfile['name'] ?? '';
          mobileController.text = userProfile['mobile'] ?? '';
        });
      }
    } catch (e) {
      // Handle errors, e.g., display an error message
      print('Error fetching user profile data: $e');
    }
  }
```
read menu item
```dart
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
        price: data['price'], 
        isAvailable: data['isAvailable'] ?? true,
      );
    }).toList();

    setState(() {
      menu.clear();
      menu.addAll(menuItems);
    });
  });
```

### Update Operation
### Delete Operation










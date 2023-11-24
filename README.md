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

### Create (Add) Operation

```dart
// Example code for adding a new item
Future<void> addItem(String itemName, double price) async {
  final CollectionReference collection = FirebaseFirestore.instance.collection('items');
  
  try {
    await collection.add({
      'name': itemName,
      'price': price,
      // Add other fields as needed
    });
    print('Item added successfully');
  } catch (e) {
    print('Error adding item: $e');
  }
}










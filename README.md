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










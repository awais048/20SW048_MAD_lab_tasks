import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  Future<User?> signIn(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Display a dialog to enter the user's name
        await _showNameDialog(context, userCredential.user!);
      } else {
        // Handle sign-in failure
        _showSignInFailedDialog(context);
      }

      return userCredential.user!;
    } catch (e) {
      print(e);
      _showSignInFailedDialog(context);
    }
    return null;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}

Future<void> _showNameDialog(BuildContext context, User user) async {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 
}

void _showSignInFailedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Sign-In Failed"),
        content: const Text("Invalid email or password. Please try again."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
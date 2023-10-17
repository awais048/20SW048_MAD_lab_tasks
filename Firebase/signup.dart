import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/auth_services.dart';
import 'package:taskmanager/homepage.dart';

class SignupPage extends StatelessWidget {
  final AuthService authService = AuthService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void _signUp(BuildContext context) async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (password == confirmPassword) {
      final user = await authService.signUpWithEmailAndPassword(email, password);
      if (user != null) {
         await usersCollection.doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        // You can add more user data fields here as needed
      });
        // Sign-up successful, you can navigate to the next screen or perform
        // other actions like storing additional user information in Firebase Firestore.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MyHomePage()), // Replace with your home screen
        );
      } else {
        // Sign-up failed, display an error message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-up failed. Please try again.'),
          ),
        );
      }
    } else {
      // Passwords don't match, display an error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body:Center(
        child: Container(
          width: 400,

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white], // Customize your gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name', labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                       ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name',labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),), ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),), ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password',
               
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _signUp(context),
                child: Text('Sign Up'),
              ),
          ],
        ),
            ),
      ), ) )
    );
  }
}



void main() {
  runApp(MaterialApp(
    home: SignupPage(),
  ));
}

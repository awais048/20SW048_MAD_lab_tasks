import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String username;
  final String password;
  final String email;
  final String dob;
  final String gender;

  const SuccessPage({
    required this.username,
    required this.password,
    required this.email,
    required this.dob,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Success Page")),
      backgroundColor: const Color.fromARGB(221, 184, 173, 173),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 180, 189, 197),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 233, 238, 243), Color.fromARGB(255, 211, 229, 212)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Username: $username"),
              Text("Email: $email"),
              Text("Gender: $gender"),
              Text("DOB: $dob"),
            ],
          ),
        ),
      ),
    );
  }
}

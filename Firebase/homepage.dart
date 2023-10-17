import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/dashboard.dart';
import 'package:taskmanager/manager.dart';
import 'package:taskmanager/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 

signIn() async {
    final AuthService authService = AuthService();
    User? user = await authService.signIn(
      context,
      _emailController.text,
      _passwordController.text,
    );

    if (user != null) {
      
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login successfull")));
 Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskManagerApp()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login failed")));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Task Manager App",style: TextStyle(fontSize: 30,color: Colors.white),),
      ),
      body:  Container(

        decoration: BoxDecoration(
         /* gradient: LinearGradient(
            colors: [
              Colors.grey,
              Colors.white
            ]
          )

          */
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.white], // Customize your gradient colors
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Login", style: TextStyle(color: Colors.white,fontSize:30,fontWeight: FontWeight.bold ),),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)


                          ),
                        ),
                      ),
                    ),

                    ElevatedButton(onPressed: (){
                      signIn();

                     
                    },
                        child: Text("Login ")),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Create an account ?"),
                    ),

                    InkWell(
                        onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()),
                           );
                        },
                        child: Text("Sign up",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold), ))

                  ],
                ),
              ),
            ),
          ),
        ),
      )

    );
  }
}

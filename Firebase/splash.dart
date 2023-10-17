import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmanager/homepage.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    Timer(Duration (seconds:5) , () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>MyHomePage())
      );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Column(
             children: [
               Container(
                    width: 300,
                   height: 300,
                   child: Image.asset("assets/images/img_1.png")),
               Center(child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Task Manager App",style: TextStyle(fontSize: 30,color: Colors.blue.shade900),),
               ))
             ],
           ),
         ],
       ),
     ),



    );

  }}



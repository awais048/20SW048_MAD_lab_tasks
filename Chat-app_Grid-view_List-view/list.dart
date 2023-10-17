import 'package:flutter/material.dart';

// ignore: camel_case_types
class list1 extends StatelessWidget {
  const list1({super.key});

  
      @override
      Widget build(BuildContext context) {
        return Scaffold(body: Mywidget(),);
      }
  // This widget is the root of your application.
    // ignore: non_constant_identifier_names
    Widget Mywidget(){
     return ListView(
      padding: const EdgeInsets.all(2),
      children: const[
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
          child: ListTile(title: Text('Hassan'),),
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
        Card(
        child:ListTile(title: Text('awais'),)
          
        ),
    ],
    );
    }
    
  
}


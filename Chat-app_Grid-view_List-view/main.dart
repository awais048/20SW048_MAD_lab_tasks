import 'package:flutter/material.dart';
import 'list.dart';
import 'grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 1',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(child: Text("List View"),),
              Tab(child: Text("Grid View"),),
              Tab(child: Text("3rd View"),),
            ]),
            title: const Text("App bar",),
          ),
          body: const TabBarView(children: [
            list1(),
            grid1(),
            Text("ok baby")
          ]),
          ),
      ),
    );
  }
}


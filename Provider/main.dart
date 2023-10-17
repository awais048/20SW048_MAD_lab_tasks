import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_ex/todo.dart';
import 'package:provider_ex/todonotifier.dart';

void main() {
  runApp(MultiProvider(providers:[ ChangeNotifierProvider(create: (BuildContext context) {
    return ToDoNotifier();
  }),],
  child: const MyApp())  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String newTaskTitle = ''; 
  Future<void> _showAddTaskDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a New Task'),
          content: TextFormField(
            onChanged: (value) {
              setState(() {
                newTaskTitle = value;
              });
            },
            decoration:const InputDecoration(labelText: 'Task Title'),
          ),
          actions: <Widget>[
            TextButton(
              child:const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:const Text('Add'),
              onPressed: () {
                if (newTaskTitle.isNotEmpty) {
                  context.read<ToDoNotifier>().addTodo(
                    Todo(isDone: false, title: newTaskTitle),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: context.watch<ToDoNotifier>().getTodos.length,
        itemBuilder: (context, index) {
          Todo todo = context.watch<ToDoNotifier>().getTodos[index];
          return ListTile(
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (value) {
                context.read<ToDoNotifier>().toggleIsDone(index);
              },
            ),
            title: Text(todo.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<ToDoNotifier>().removeTodo(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

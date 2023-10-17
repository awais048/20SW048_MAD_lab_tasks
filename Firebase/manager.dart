import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    home: TaskManagerApp(),
  ));
}

class Task {
  final String date;
  final String time;
  final String title;
  final String description;

  Task(this.date, this.time, this.title, this.description);
}

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? editingTaskId;

  void addItem(String title, String description, String time, String date) async {
    try {
      await tasks.add({
        "title": title,
        "description": description,
        "date": date,
        "time": time,
      });
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  void editItem(
      String id, String title, String description, String time, String date) async {
    try {
      await tasks.doc(id).update({
        "title": title,
        "description": description,
        "date": date,
        "time": time,
      });
    } catch (e) {
      print('Error editing task: $e');
    }
  }

  void deleteItem(String id) async {
    try {
      await tasks.doc(id).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  void _showAddTaskDialog(BuildContext context, {String? buttonText}) {
    if (buttonText != null) {
      final item = tasks.doc(buttonText);
      item.get().then((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          titleController.text = data['title'];
          descriptionController.text = data['description'];
          dateController.text = data['date'];
          timeController.text = data['time'];
        }
      });
    } else {
      titleController.clear();
      descriptionController.clear();
      dateController.clear();
      timeController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(buttonText != null ? 'Edit Task' : 'Add Task',style: TextStyle(color: Colors.blue),),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (selectedTime != null) {
                      String formattedTime = selectedTime.format(context);
                      setState(() {
                        timeController.text = formattedTime;
                      });
                    }
                  },
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String formattedDateWithDay =
                          DateFormat('EEEE, MMMM d, y').format(pickedDate);
                      setState(() {
                        dateController.text = formattedDateWithDay;
                      });
                    }
                  },
                ),


              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (buttonText != null) {
                  editItem(
                    buttonText,
                    titleController.text,
                    descriptionController.text,
                    dateController.text,
                    timeController.text,
                  );
                } else {
                  addItem(
                    titleController.text,
                    descriptionController.text,
                    dateController.text,
                    timeController.text,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(buttonText != null ? 'Save Changes' : 'Add Task'),
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
        title: const Text("Task Manager"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                _showAddTaskDialog(context);
              },
              child: Text('Add Task'),
            ),
            Expanded(
              child: StreamBuilder(
                stream: tasks.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  final taskList =
                      (snapshot.data as QuerySnapshot).docs.reversed.toList();
                  return ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      final title = taskList[index]["title"];
                      final description = taskList[index]["description"];
                      final date = taskList[index]["date"];
                      final time = taskList[index]["time"];
                      final taskId = taskList[index].id;

                      return ListTile(
                        title: Text(title,style: TextStyle(color: Colors.blue),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(description,style: TextStyle(color: Colors.grey),),
                            Text(time,style: TextStyle(color: Colors.green),),
                            Text(date,style: TextStyle(color: Colors.red),)],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showAddTaskDialog(context, buttonText: taskId);
                              },
                              icon: Icon(Icons.edit,color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteItem(taskId);
                              },
                              icon: Icon(Icons.delete,color: Colors.red, ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

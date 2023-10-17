import 'package:flutter/material.dart';
import 'package:provider_ex/todo.dart';

class ToDoNotifier with ChangeNotifier{
  List<Todo> todos=[];
  List<Todo> get getTodos => todos;

  addTodo(Todo todo){
    todos.add(todo);
    notifyListeners();

  }
  removeTodo(int index){
    todos.removeAt(index);
    notifyListeners();

  } 
  toggleIsDone(int index){
    todos[index].isDone=!todos[index].isDone;
    notifyListeners();
  }


}
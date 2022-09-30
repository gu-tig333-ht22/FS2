import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoModel {
  String? id;
  String? title;
  bool done;

  TodoModel({this.id, this.title, this.done = false});

  void isDone() {
    done = !done;
  }
}

class MyState extends ChangeNotifier {
  List<TodoModel> _tasks = [];
  List<TodoModel> get tasks => _tasks;

  String _filter = 'All';
  String get filter => _filter;

  void updateFilter(String filterBy) {
    _filter = filterBy;
    notifyListeners();
  }

  void doStuff() async {
    var result = await fetch();
    notifyListeners();
  }

  MyState() {
    doStuff();
  }

  Future<Object?> fetch() async {
    http.Response response = await http.get(
        Uri.parse('https://todo-2a81c-default-rtdb.firebaseio.com/todo.json'));
    var jsondata = response.body;
    var obj = jsonDecode(jsondata);
    var tom = [];
    obj.forEach((prodid, proddata) {
      tom.add(TodoModel(
          id: prodid, title: proddata['Todo'], done: proddata['done']));
    });

    tom.forEach((element) {
      var element_TodoModel = element as TodoModel;
      tasks.add(element_TodoModel);
    });
  }

  void addTask(TodoModel task) async {
    var response = await http
        .post(
            Uri.parse(
                'https://todo-2a81c-default-rtdb.firebaseio.com/todo.json'),
            body: jsonEncode({'Todo': task.title, 'done': task.done}))
        .then((response) {
      final ToDo = TodoModel(
          id: json.decode(response.body)['name'] as String,
          title: task.title,
          done: task.done);
      tasks.add(ToDo);
      notifyListeners();
    });
  }

  void checkTask(TodoModel task) {
    final taskIndex = tasks.indexOf(task);
    if (tasks[taskIndex].done == false) {
      final url = Uri.parse(
          'https://todo-2a81c-default-rtdb.firebaseio.com/todo/${task.id}.json');
      http.put(url,
          body: jsonEncode({'Todo': task.title, 'id': task.id, 'done': true}));
      tasks[taskIndex].isDone();
      notifyListeners();
    } else {
      final url = Uri.parse(
          'https://todo-2a81c-default-rtdb.firebaseio.com/todo/${task.id}.json');
      http.put(url,
          body: jsonEncode({'Todo': task.title, 'id': task.id, 'done': false}));
      tasks[taskIndex].isDone();
      notifyListeners();
    }
  }

  void deleteTask(TodoModel task) {
    final url = Uri.parse(
        'https://todo-2a81c-default-rtdb.firebaseio.com/todo/${task.id}.json');
    http.delete(url);
    tasks.remove(task);
    notifyListeners();
  }
}

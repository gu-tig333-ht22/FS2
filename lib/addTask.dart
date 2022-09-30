import 'package:flutter/material.dart';

import 'model.dart';

class addTask extends StatefulWidget {
  final TodoModel task;
  addTask(this.task);

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add task'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Skriv in din task',
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.pop(
                    context,
                    TodoModel(
                        title: taskController.text.toString(), done: false));
              },
            ),
          ],
        ),
      ),
    );
  }
}

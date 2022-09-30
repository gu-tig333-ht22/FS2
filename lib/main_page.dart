import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_action.dart';
import 'addTask.dart';
import 'model.dart';

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My ToDo App"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              Provider.of<MyState>(context, listen: false)
                  .updateFilter(value.toString());
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Alla'),
                value: 'Alla',
              ),
              PopupMenuItem(child: Text('Klara'), value: 'Klara'),
              PopupMenuItem(child: Text('Icke klara'), value: 'Icke klara'),
            ],
          ),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            TodoAction(_filterList(state.tasks, state.filter), state.filter),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: "Add a todo",
          onPressed: () async {
            var newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        addTask(TodoModel(id: '', title: '', done: false))));
            if (newTask != null) {
              Provider.of<MyState>(context, listen: false).addTask(newTask);
            }
          },
          child: const Icon(Icons.add)),
    );
  }

  List<TodoModel> _filterList(list, filterBy) {
    if (filterBy == 'Alla') return list;
    if (filterBy == 'Klara') {
      return list.where((item) => item.done == true).toList();
    }
    if (filterBy == 'Icke klara') {
      return list.where((item) => item.done == false).toList();
    }
    return list;
  }
}

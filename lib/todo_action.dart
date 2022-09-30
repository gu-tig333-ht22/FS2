import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class TodoAction extends StatelessWidget {
  final List<TodoModel> list;
  String filter;

  TodoAction(this.list, this.filter);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) => ListTile(
                  leading: Checkbox(
                      value: list[index].done,
                      onChanged: ((_) =>
                          (Provider.of<MyState>(context, listen: false)
                              .checkTask(list[index])))),
                  title: Text(list[index].title.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          decoration: list[index].done
                              ? TextDecoration.lineThrough
                              : null)),
                  trailing: IconButton(
                      onPressed: () {
                        Provider.of<MyState>(context, listen: false)
                            .deleteTask(list[index]);
                      },
                      icon:
                          const Icon(Icons.remove_circle, color: Colors.black)),
                )),
          ),
        ),
      ],
    );
  }
}

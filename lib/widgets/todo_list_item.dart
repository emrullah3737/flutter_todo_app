import 'package:flutter/material.dart';
import 'package:flutterapp2/models/todo.dart';

enum TodoOptions { delete, edit }

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final double bottomMargin;
  final Function onPressDelete;

  const TodoListItem({
    this.todo,
    this.bottomMargin = 0,
    this.onPressDelete,
  });

  void onSelectTodoOption(TodoOptions todoOptions) {
    if (todoOptions == TodoOptions.delete) {
      onPressDelete(todo);
      return;
    }

    if (todoOptions == TodoOptions.edit) {
      // TODO: update process
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
      child: Card(
        color: Colors.redAccent,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        todo.title.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                    PopupMenuButton<TodoOptions>(
                      onSelected: onSelectTodoOption,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<TodoOptions>>[
                        PopupMenuItem<TodoOptions>(
                          value: TodoOptions.delete,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.delete),
                              SizedBox(width: 10),
                              Text('Delete Todo'),
                            ],
                          ),
                        ),
                        PopupMenuItem<TodoOptions>(
                          value: TodoOptions.edit,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit),
                              SizedBox(width: 10),
                              Text('Update Todo'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                ),
                Text(
                  todo.content,
                  style: TextStyle(
                      fontSize: 12, letterSpacing: 1, color: Colors.white),
                )
              ]),
        ),
      ),
    );
  }
}

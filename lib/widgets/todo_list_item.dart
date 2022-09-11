import 'package:flutter/material.dart';
import 'package:flutterapp2/models/todo.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

enum TodoOptions { delete, edit }

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final double bottomMargin;
  final Function onPressDelete;
  final Function onPressEdit;

  const TodoListItem({
    this.todo,
    this.bottomMargin = 0,
    this.onPressDelete,
    this.onPressEdit,
  });

  void onSelectTodoOption(TodoOptions todoOptions) {
    if (todoOptions == TodoOptions.delete) {
      onPressDelete(todo);
      return;
    }

    if (todoOptions == TodoOptions.edit) {
      onPressEdit(todo);
      return;
    }
  }

  String formattedUpdatedAtDate() {
    final DateTime now = DateTime.now();
    final Duration diff = now.difference(todo.updatedAt);

    return timeago.format(now.subtract(diff));
  }

  String formattedCreatedAtDate() {
    DateFormat formatter = DateFormat('dd MMM yyyy');

    return formatter.format(todo.createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
      child: Card(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      formattedCreatedAtDate(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
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
                          color: Colors.black,
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
                              Text('Edit Todo'),
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
                      fontSize: 12, letterSpacing: 1, color: Colors.black87),
                ),
                SizedBox(height: 30),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Last updated ${formattedUpdatedAtDate()}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

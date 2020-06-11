import 'package:flutter/material.dart';
import 'package:flutterapp2/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final double bottomMargin;
  final Function onPressDelete;

  const TodoListItem({
    this.todo,
    this.bottomMargin = 0,
    this.onPressDelete,
  });

  void _onPressDelete() {
    onPressDelete(todo);
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
                    IconButton(
                      onPressed: _onPressDelete,
                      tooltip: "Delete",
                      color: Colors.white,
                      icon: Icon(Icons.delete),
                    )
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

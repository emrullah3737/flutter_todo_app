import 'package:flutter/material.dart';
import 'package:flutterapp2/models/todo.dart';
import 'package:flutterapp2/widgets/todo_list_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Todo> todoList = [];
  int counter = 0;

  void addTodo() {
    counter += 1;
    setState(() {
      todoList.add(Todo(
          title:
              '$counter It has roots in a piece of classical Latin literature',
          content:
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,'));
    });
  }

  void deleteTodo(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: todoList
                    .map((Todo todo) => TodoListItem(
                          todo: todo,
                          onPressDelete: deleteTodo,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}

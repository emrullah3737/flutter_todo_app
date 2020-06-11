import 'package:flutter/material.dart';
import 'package:flutterapp2/models/todo.dart';
import 'package:flutterapp2/widgets/todo_list_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Todo> todoList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void addTodo(BuildContext context) {
    setState(() {
      todoList.add(
          Todo(title: titleController.text, content: contentController.text));
    });
    Navigator.pop(context);
  }

  void deleteTodo(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void onPressAddTodo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Text('New Todo'),
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: contentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                        labelText: 'Content',
                      ),
                    ),
                    Divider(height: 20),
                    RaisedButton(
                      onPressed: () => addTodo(context),
                      color: Colors.redAccent,
                      child: Text('Add Todo',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).then((value) => clearAddTodoForm());
  }

  void clearAddTodoForm() {
    titleController.clear();
    contentController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
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
              child: ListView(
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
        onPressed: onPressAddTodo,
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}

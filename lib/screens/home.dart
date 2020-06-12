import 'package:flutter/material.dart';
import 'package:flutterapp2/models/todo.dart';
import 'package:flutterapp2/widgets/todo_list_item.dart';

enum TodoFormType { add, edit }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Todo> todoList = [];
  final GlobalKey<FormState> todoFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void addTodo(BuildContext context) {
    if (!validateTodoForm()) return;

    setState(() {
      todoList.add(
          Todo(title: titleController.text, content: contentController.text));
    });
    Navigator.pop(context);
  }

  void updateTodo(BuildContext context, Todo activeTodo) {
    if (!validateTodoForm()) return;

    setState(() {
      activeTodo.title = titleController.text;
      activeTodo.content = contentController.text;
      activeTodo.updatedAt = DateTime.now();
    });
    Navigator.pop(context);
  }

  void onPressDeleteTodo(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void onPressEditTodo(Todo todo) {
    titleController.text = todo.title;
    contentController.text = todo.content;
    showTodoFormDialog(
      todoFormType: TodoFormType.edit,
      activeTodo: todo,
    );
  }

  void onPressAddTodo() {
    showTodoFormDialog(
      todoFormType: TodoFormType.add,
    );
  }

  bool validateTodoForm() {
    return todoFormKey.currentState.validate();
  }

  String emptyValidator(value) {
    if (value.isEmpty) {
      return 'Field Required!';
    }
    return null;
  }

  void showTodoFormDialog({TodoFormType todoFormType, Todo activeTodo}) {
    final String dialogTitle =
        todoFormType == TodoFormType.add ? 'New Todo' : 'Edit Todo';
    final String dialogButton =
        todoFormType == TodoFormType.add ? 'Add Todo' : 'Confirm Todo';

    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return Form(
            key: todoFormKey,
            child: SimpleDialog(
              backgroundColor: Colors.white,
              title: Center(child: Text(dialogTitle)),
              children: <Widget>[
                Divider(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        validator: emptyValidator,
                        controller: titleController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Title',
                        ),
                        maxLength: 10,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        validator: emptyValidator,
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
                        onPressed: () {
                          if (todoFormType == TodoFormType.add) {
                            addTodo(buildContext);
                            return;
                          }

                          if (todoFormType == TodoFormType.edit) {
                            updateTodo(buildContext, activeTodo);
                            return;
                          }
                        },
                        color: Colors.redAccent,
                        child: Text(dialogButton,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).then((value) => clearTodoForm());
  }

  void clearTodoForm() {
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
    todoList.sort((b, a) => a.createdAt.compareTo(b.createdAt));

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: ListView(
                children: todoList
                    .map((Todo todo) => TodoListItem(
                          todo: todo,
                          onPressDelete: onPressDeleteTodo,
                          onPressEdit: onPressEditTodo,
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

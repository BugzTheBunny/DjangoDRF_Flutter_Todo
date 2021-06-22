import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final todoTitleController = TextEditingController();
  final todoDesController = TextEditingController();

  void onAdd() {
    final String textValidation = todoTitleController.text;
    final String desValidation = todoDesController.text;

    if (textValidation.isNotEmpty && desValidation.isNotEmpty) {
      final Todo todo = Todo(
          id: 0,
          status: false,
          title: textValidation,
          description: desValidation);
      Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(25),
            child: Column(
              children: [
                TextField(
                  controller: todoTitleController,
                  decoration: InputDecoration(
                      hintText: 'Input a task',
                      hintStyle: TextStyle(color: Colors.black26)),
                ),
                TextField(
                  controller: todoDesController,
                  decoration: InputDecoration(
                      hintText: 'Describe the task..',
                      hintStyle: TextStyle(color: Colors.black26)),
                ),
                ElevatedButton(
                  onPressed: () {
                    onAdd();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

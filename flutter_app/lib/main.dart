import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:provider/provider.dart';
import './screens/addTodo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Todo App Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          'Flutter + Django Todo',
          style: TextStyle(fontFamily: 'KaushanScript', fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todoP.todos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              tileColor: Colors.blue[50],
              leading: todoP.todos[index].status == true
                  ? IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        todoP.updateTodo(todoP.todos[index]);
                      })
                  : IconButton(
                      icon: Icon(
                        Icons.done,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        todoP.updateTodo(todoP.todos[index]);
                      }),
              trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 35,
                  ),
                  onPressed: () {
                    todoP.removeTodo(todoP.todos[index]);
                  }),
              title: todoP.todos[index].status == true
                  ? Text(
                      "${todoP.todos[index].id} : ${todoP.todos[index].title}",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                  : Text(
                      "${todoP.todos[index].id} : ${todoP.todos[index].title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
              subtitle: Text(todoP.todos[index].description),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddTodo()));
        },
      ),
    );
  }
}

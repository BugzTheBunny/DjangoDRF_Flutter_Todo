import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  TodoProvider() {
    this.fetchTasks();
  }

  List<Todo> _todos = [];

  List<Todo> get todos {
    return [..._todos];
  }

  void addTodo(Todo todo) async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/v1/');
    final response = await http.post(url,
        body:
            json.encode({'title': todo.title, 'description': todo.description}),
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 201) {
      todo.id = json.decode(response.body)['id'];
      _todos.add(todo);
      notifyListeners();
    }
  }

  void removeTodo(Todo todo) async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/v1/${todo.id}/');
    final response = await http.delete(url,
        body:
            json.encode({'title': todo.title, 'description': todo.description}),
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  void updateTodo(Todo todo) async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/v1/${todo.id}/');
    if (todo.status == true) {
      todo.status = false;
    } else {
      todo.status = true;
    }
    final response = await http.patch(url,
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
          'status': todo.status,
        }),
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      notifyListeners();
    }
  }

  fetchTasks() async {
    final url = Uri.parse('http://10.0.2.2:8000/apis/v1/?format=json');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos = data.map<Todo>((json) => Todo.fromJson(json)).toList();
      notifyListeners();
    }
  }
}

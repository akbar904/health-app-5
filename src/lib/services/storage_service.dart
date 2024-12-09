import 'dart:convert';
import 'package:gyde_app/models/todo.dart';

class StorageService {
  final List<Todo> _todos = [];

  Future<List<Todo>> getTodos() async {
    return List<Todo>.from(_todos)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveTodo(Todo todo) async {
    _todos.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
  }

  String _encode(List<Todo> todos) =>
      json.encode(todos.map((todo) => todo.toJson()).toList());

  List<Todo> _decode(String str) =>
      (json.decode(str) as List).map((item) => Todo.fromJson(item)).toList();
}

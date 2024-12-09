import 'package:flutter/material.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/features/todo/todo_repository.dart';
import 'package:stacked/stacked.dart';

class TodoViewModel extends BaseViewModel {
  final _todoRepository = locator<TodoRepository>();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  String _filter = 'all';
  String get filter => _filter;

  List<Todo> get filteredTodos {
    switch (_filter) {
      case 'active':
        return _todos.where((todo) => !todo.isCompleted).toList();
      case 'completed':
        return _todos.where((todo) => todo.isCompleted).toList();
      default:
        return _todos;
    }
  }

  Future<void> initialize() async {
    setBusy(true);
    _todos = await _todoRepository.getTodos();
    setBusy(false);
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  Future<void> addTodo(String title, String description) async {
    if (title.isEmpty) return;

    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _todoRepository.addTodo(todo);
    _todos = await _todoRepository.getTodos();
    notifyListeners();
  }

  Future<void> toggleTodo(String id) async {
    await _todoRepository.toggleTodoCompletion(id);
    _todos = await _todoRepository.getTodos();
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await _todoRepository.deleteTodo(id);
    _todos = await _todoRepository.getTodos();
    notifyListeners();
  }

  Future<void> updateTodo(
    String id,
    String title,
    String description,
  ) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    final updatedTodo = todo.copyWith(
      title: title,
      description: description,
      updatedAt: DateTime.now(),
    );

    await _todoRepository.updateTodo(updatedTodo);
    _todos = await _todoRepository.getTodos();
    notifyListeners();
  }
}

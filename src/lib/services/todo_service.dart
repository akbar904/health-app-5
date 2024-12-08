import 'dart:async';
import 'package:gyde_app/models/todo.dart';

class TodoService {
  final _todoController = StreamController<List<Todo>>.broadcast();
  List<Todo> _todos = [];

  Stream<List<Todo>> get todosStream => _todoController.stream;
  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    _updateTodos();
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      _updateTodos();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _updateTodos();
  }

  void toggleTodoComplete(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      _updateTodos();
    }
  }

  List<Todo> filterTodos({
    bool? isCompleted,
    String searchQuery = '',
  }) {
    return _todos.where((todo) {
      if (isCompleted != null && todo.isCompleted != isCompleted) {
        return false;
      }
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return todo.title.toLowerCase().contains(query) ||
            todo.description.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }

  void _updateTodos() {
    _todoController.add(_todos);
  }

  void dispose() {
    _todoController.close();
  }
}

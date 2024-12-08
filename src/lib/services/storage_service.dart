import 'package:gyde_app/models/todo.dart';

class StorageService {
  final List<Todo> _todos = [];

  List<Todo> getTodos() {
    return List.from(_todos);
  }

  void saveTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void clearTodos() {
    _todos.clear();
  }
}

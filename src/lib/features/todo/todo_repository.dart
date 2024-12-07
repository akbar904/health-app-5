import 'package:gyde_app/models/todo_model.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  List<Todo> getTodos() {
    return _todos;
  }

  void addTodo(Todo todo) {
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

  void toggleTodoComplete(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
    }
  }
}

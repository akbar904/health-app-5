import 'package:gyde_app/models/todo_item.dart';

class TodoService {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  void addTodo(TodoItem todo) {
    _todos.add(todo);
  }

  void updateTodo(TodoItem todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
    }
  }
}

import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/utils/todo_filter.dart';

class TodoService {
  final List<TodoItem> _todos = [];

  List<TodoItem> getTodos() => List.unmodifiable(_todos);

  List<TodoItem> getFilteredTodos(TodoFilter filter) {
    switch (filter) {
      case TodoFilter.all:
        return getTodos();
      case TodoFilter.active:
        return getTodos().where((todo) => !todo.isCompleted).toList();
      case TodoFilter.completed:
        return getTodos().where((todo) => todo.isCompleted).toList();
    }
  }

  void addTodo(TodoItem todo) {
    _todos.add(todo);
  }

  void updateTodo(TodoItem updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }

  void toggleTodoComplete(String todoId) {
    final index = _todos.indexWhere((todo) => todo.id == todoId);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
    }
  }

  void deleteTodo(String todoId) {
    _todos.removeWhere((todo) => todo.id == todoId);
  }
}

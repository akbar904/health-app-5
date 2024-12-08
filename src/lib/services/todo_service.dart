import 'package:gyde_app/models/todo.dart';
import 'package:stacked/stacked.dart';

class TodoService with ListenableServiceMixin {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      notifyListeners();
    }
  }

  List<Todo> getFilteredTodos({bool? isCompleted}) {
    if (isCompleted == null) return _todos;
    return _todos.where((todo) => todo.isCompleted == isCompleted).toList();
  }
}

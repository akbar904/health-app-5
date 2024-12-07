import 'package:gyde_app/models/todo.dart';
import 'package:stacked/stacked_annotations.dart';

@lazySingleton
class TodoService {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().toIso8601String(),
      title: title,
    );
    _todos.add(todo);
  }

  void toggleTodo(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todos[todoIndex].isCompleted = !_todos[todoIndex].isCompleted;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void clearCompletedTodos() {
    _todos.removeWhere((todo) => todo.isCompleted);
  }

  int get totalTodos => _todos.length;
  int get completedTodos => _todos.where((todo) => todo.isCompleted).length;
  int get pendingTodos => _todos.where((todo) => !todo.isCompleted).length;
}

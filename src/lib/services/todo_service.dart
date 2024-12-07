import 'package:gyde_app/models/todo_model.dart';
import 'package:stacked/stacked.dart';

class TodoService with ListenableServiceMixin {
  final List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  TodoService() {
    listenToReactiveValues([_todos]);
  }

  void addTodo(TodoModel todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(TodoModel todo) {
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
      _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
      notifyListeners();
    }
  }

  List<TodoModel> getFilteredTodos(String filter) {
    switch (filter.toLowerCase()) {
      case 'all':
        return _todos;
      case 'completed':
        return _todos.where((todo) => todo.isCompleted).toList();
      case 'active':
        return _todos.where((todo) => !todo.isCompleted).toList();
      default:
        return _todos;
    }
  }

  int get totalTodos => _todos.length;
  int get completedTodos => _todos.where((todo) => todo.isCompleted).length;
  int get activeTodos => _todos.where((todo) => !todo.isCompleted).length;
}

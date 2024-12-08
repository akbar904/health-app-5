import 'package:gyde_app/models/todo_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class TodoService with ListenableServiceMixin {
  final _logger = Logger();
  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;
  List<TodoModel> get completedTodos =>
      _todos.where((todo) => todo.isComplete).toList();
  List<TodoModel> get incompleteTodos =>
      _todos.where((todo) => !todo.isComplete).toList();

  TodoService() {
    _loadInitialTodos();
  }

  void _loadInitialTodos() {
    _todos = TodoModel.mockTodos;
    notifyListeners();
  }

  void addTodo(String title) {
    final newTodo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    _todos.add(newTodo);
    _logger.i('Added new todo: ${newTodo.title}');
    notifyListeners();
  }

  void toggleTodoStatus(String todoId) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
    if (todoIndex != -1) {
      _todos[todoIndex] = _todos[todoIndex].copyWith(
        isComplete: !_todos[todoIndex].isComplete,
        completedAt: !_todos[todoIndex].isComplete ? DateTime.now() : null,
      );
      _logger.i('Toggled todo status: ${_todos[todoIndex].title}');
      notifyListeners();
    }
  }

  void updateTodoTitle(String todoId, String newTitle) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
    if (todoIndex != -1) {
      _todos[todoIndex] = _todos[todoIndex].copyWith(title: newTitle);
      _logger.i('Updated todo title: ${_todos[todoIndex].title}');
      notifyListeners();
    }
  }

  void deleteTodo(String todoId) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
    if (todoIndex != -1) {
      final deletedTodo = _todos.removeAt(todoIndex);
      _logger.i('Deleted todo: ${deletedTodo.title}');
      notifyListeners();
    }
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isComplete);
    _logger.i('Cleared completed todos');
    notifyListeners();
  }
}

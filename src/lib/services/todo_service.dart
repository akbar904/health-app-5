import 'dart:async';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/utils/enums/todo_priority.dart';

class TodoService {
  final List<Todo> _todos = [];
  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todosStream => _todoController.stream;
  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(String title, String description, TodoPriority priority) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      priority: priority,
    );
    _todos.add(todo);
    _notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      _notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    final index = _todos.indexOf(todo);
    _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
    _notifyListeners();
  }

  List<Todo> getTodosByFilter(String filter) {
    switch (filter) {
      case 'active':
        return _todos.where((todo) => !todo.isCompleted).toList();
      case 'completed':
        return _todos.where((todo) => todo.isCompleted).toList();
      default:
        return _todos;
    }
  }

  void _notifyListeners() {
    _todoController.add(_todos);
  }

  void dispose() {
    _todoController.close();
  }
}

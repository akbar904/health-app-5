import 'dart:async';
import 'package:gyde_app/models/todo_item.dart';

class TodoService {
  final List<TodoItem> _todos = [];
  final _todoController = StreamController<List<TodoItem>>.broadcast();

  Stream<List<TodoItem>> get todosStream => _todoController.stream;
  List<TodoItem> get todos => List.unmodifiable(_todos);

  void addTodo(TodoItem todo) {
    _todos.add(todo);
    _notifyListeners();
  }

  void updateTodo(TodoItem updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
      _notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _notifyListeners();
  }

  void toggleTodoComplete(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] =
          _todos[index].copyWith(isCompleted: !_todos[index].isCompleted);
      _notifyListeners();
    }
  }

  List<TodoItem> filterTodos({bool? isCompleted}) {
    if (isCompleted == null) return _todos;
    return _todos.where((todo) => todo.isCompleted == isCompleted).toList();
  }

  void _notifyListeners() {
    _todoController.add(_todos);
  }

  void dispose() {
    _todoController.close();
  }
}

import 'dart:async';
import 'package:gyde_app/models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];
  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todosStream => _todoController.stream;
  List<Todo> get todos => List.unmodifiable(_todos);

  void dispose() {
    _todoController.close();
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
    _todoController.add(_todos);
  }

  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      _todoController.add(_todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
    _todoController.add(_todos);
  }

  Future<void> toggleTodoCompletion(String id) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        updatedAt: DateTime.now(),
      );
      _todoController.add(_todos);
    }
  }

  Future<List<Todo>> getTodos() async {
    return _todos;
  }
}

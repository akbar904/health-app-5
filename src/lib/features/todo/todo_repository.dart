import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';

class TodoRepository {
  final TodoService _todoService;

  TodoRepository(this._todoService);

  Stream<List<Todo>> get todosStream => _todoService.todosStream;

  Future<void> addTodo(Todo todo) async {
    await _todoService.addTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoService.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
  }

  Future<void> toggleTodoCompletion(String id) async {
    await _todoService.toggleTodoCompletion(id);
  }

  Future<List<Todo>> getTodos() async {
    return _todoService.getTodos();
  }
}

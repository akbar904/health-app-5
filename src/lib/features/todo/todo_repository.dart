import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/storage_service.dart';

class TodoRepository {
  final StorageService _storageService;

  TodoRepository(this._storageService);

  Future<List<Todo>> getTodos() async {
    return _storageService.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await _storageService.saveTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _storageService.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _storageService.deleteTodo(id);
  }

  Future<void> toggleTodoStatus(String id) async {
    final todos = await getTodos();
    final todo = todos.firstWhere((todo) => todo.id == id);
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await updateTodo(updatedTodo);
  }
}

import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/api_service.dart';

class TodoRepository {
  final ApiService _apiService;

  TodoRepository(this._apiService);

  Future<List<Todo>> getTodos() async {
    try {
      final response = await _apiService.get('/todos');
      return (response as List).map((json) => Todo.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Todo> createTodo(String title) async {
    try {
      final response = await _apiService.post(
        '/todos',
        data: {'title': title, 'completed': false},
      );
      return Todo.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await _apiService.put(
        '/todos/${todo.id}',
        data: todo.toJson(),
      );
      return Todo.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _apiService.delete('/todos/$id');
    } catch (e) {
      rethrow;
    }
  }
}

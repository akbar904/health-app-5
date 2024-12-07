import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/repository/todo_repository.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  Future<List<Todo>> getTodos() async {
    return await _repository.getTodos();
  }

  Future<Todo> createTodo(String title) async {
    return await _repository.createTodo(title);
  }

  Future<Todo> updateTodo(Todo todo) async {
    return await _repository.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
  }

  Future<Todo> toggleTodoComplete(Todo todo) async {
    final updatedTodo = todo.copyWith(completed: !todo.completed);
    return await _repository.updateTodo(updatedTodo);
  }
}

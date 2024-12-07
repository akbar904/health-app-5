import 'package:gyde_app/features/todo/todo_repository.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  List<Todo> getTodos() {
    return _repository.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    _repository.addTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    _repository.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    _repository.deleteTodo(id);
  }

  Future<void> toggleTodoComplete(String id) async {
    _repository.toggleTodoComplete(id);
  }
}

import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/todo.dart';

class TodoService with ListenableServiceMixin {
  TodoService() {
    listenToReactiveValues([_todos]);
  }

  final ReactiveValue<List<Todo>> _todos = ReactiveValue<List<Todo>>([]);
  List<Todo> get todos => _todos.value;

  void addTodo(Todo todo) {
    _todos.value = [..._todos.value, todo];
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = _todos.value.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      final newList = List<Todo>.from(_todos.value);
      newList[index] = todo;
      _todos.value = newList;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.value = _todos.value.where((todo) => todo.id != id).toList();
    notifyListeners();
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos.value[index];
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      final newList = List<Todo>.from(_todos.value);
      newList[index] = updatedTodo;
      _todos.value = newList;
      notifyListeners();
    }
  }

  List<Todo> filterTodos({bool? isCompleted}) {
    if (isCompleted == null) return _todos.value;
    return _todos.value
        .where((todo) => todo.isCompleted == isCompleted)
        .toList();
  }
}

import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/features/todo/todo_repository.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum TodoFilter { all, active, completed }

class TodoViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _todoRepository = locator<TodoRepository>();

  List<Todo> _todos = [];
  TodoFilter _currentFilter = TodoFilter.all;

  List<Todo> get todos {
    switch (_currentFilter) {
      case TodoFilter.active:
        return _todos.where((todo) => !todo.isCompleted).toList();
      case TodoFilter.completed:
        return _todos.where((todo) => todo.isCompleted).toList();
      case TodoFilter.all:
      default:
        return _todos;
    }
  }

  TodoFilter get currentFilter => _currentFilter;

  Future<void> initialize() async {
    setBusy(true);
    await loadTodos();
    setBusy(false);
  }

  Future<void> loadTodos() async {
    try {
      _todos = await _todoRepository.getTodos();
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> addTodo(String title, String description) async {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    try {
      await _todoRepository.addTodo(todo);
      await loadTodos();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _todoRepository.updateTodo(todo);
      await loadTodos();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      try {
        await _todoRepository.deleteTodo(id);
        await loadTodos();
      } catch (e) {
        setError(e);
      }
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      await _todoRepository.toggleTodoStatus(id);
      await loadTodos();
    } catch (e) {
      setError(e);
    }
  }

  void setFilter(TodoFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }
}

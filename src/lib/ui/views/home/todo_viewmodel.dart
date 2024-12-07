import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends ReactiveViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  String _currentFilter = 'all';
  String get currentFilter => _currentFilter;

  List<TodoModel> get todos => _todoService.getFilteredTodos(_currentFilter);
  int get totalTodos => _todoService.totalTodos;
  int get completedTodos => _todoService.completedTodos;
  int get activeTodos => _todoService.activeTodos;

  void setFilter(String filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  Future<void> addTodo(String title, String description) async {
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _todoService.addTodo(todo);
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
    }
  }

  Future<void> editTodo(TodoModel todo) async {
    _todoService.updateTodo(todo);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_todoService];
}

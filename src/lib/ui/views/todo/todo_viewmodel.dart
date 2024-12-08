import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _logger = Logger();

  List<TodoModel> get todos => _todoService.todos;
  List<TodoModel> get completedTodos => _todoService.completedTodos;
  List<TodoModel> get incompleteTodos => _todoService.incompleteTodos;

  bool _showCompleted = false;
  bool get showCompleted => _showCompleted;

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) {
      _logger.w('Attempted to add empty todo');
      return;
    }
    _todoService.addTodo(title);
    notifyListeners();
  }

  void toggleTodoStatus(String todoId) {
    _todoService.toggleTodoStatus(todoId);
    notifyListeners();
  }

  Future<void> updateTodoTitle(String todoId) async {
    final todo = todos.firstWhere((todo) => todo.id == todoId);
    final response = await _dialogService.showDialog(
      title: 'Edit Todo',
      description: 'Update the todo title',
      barrierDismissible: true,
      defaultValue: todo.title,
    );

    if (response?.confirmed ?? false) {
      final newTitle = response?.data as String;
      if (newTitle.trim().isNotEmpty) {
        _todoService.updateTodoTitle(todoId, newTitle);
        notifyListeners();
      }
    }
  }

  Future<void> deleteTodo(String todoId) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(todoId);
      notifyListeners();
    }
  }

  void clearCompleted() {
    _todoService.clearCompleted();
    notifyListeners();
  }
}

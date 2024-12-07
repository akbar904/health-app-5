import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<Todo> _todos = [];
  bool _showCompleted = true;
  bool _showIncomplete = true;

  List<Todo> get todos => _todos.where((todo) {
        if (_showCompleted && _showIncomplete) return true;
        if (_showCompleted) return todo.isCompleted;
        if (_showIncomplete) return !todo.isCompleted;
        return false;
      }).toList();

  void initialize() {
    _todos = _todoService.getTodos();
    notifyListeners();
  }

  Future<void> navigateToAddTodo() async {
    await _navigationService.navigateToAddTodoView();
    initialize();
  }

  Future<void> toggleTodoComplete(String id) async {
    await _todoService.toggleTodoComplete(id);
    initialize();
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (response?.confirmed ?? false) {
      await _todoService.deleteTodo(id);
      initialize();
    }
  }

  Future<void> editTodo(Todo todo) async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: todo,
    );

    if (result?.confirmed ?? false) {
      final updatedTodo = result?.data as Todo;
      await _todoService.updateTodo(updatedTodo);
      initialize();
    }
  }

  void updateFilter(bool showCompleted, bool showIncomplete) {
    _showCompleted = showCompleted;
    _showIncomplete = showIncomplete;
    notifyListeners();
  }
}

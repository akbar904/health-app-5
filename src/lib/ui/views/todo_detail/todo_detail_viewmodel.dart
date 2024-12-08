import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoDetailViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  late Todo _todo;
  Todo get todo => _todo;

  void initialize(Todo todo) {
    _todo = todo;
  }

  void toggleCompletion() {
    _todoService.toggleTodoCompletion(_todo.id);
    _todo = _todoService.todos.firstWhere((t) => t.id == _todo.id);
    rebuildUi();
  }

  Future<void> deleteTodo() async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(_todo.id);
      _navigationService.back();
    }
  }
}

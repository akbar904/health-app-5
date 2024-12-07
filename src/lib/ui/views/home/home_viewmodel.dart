import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Todo> get todos => _todoService.todos;
  int get totalTodos => _todoService.totalTodos;
  int get completedTodos => _todoService.completedTodos;
  int get pendingTodos => _todoService.pendingTodos;

  Future<void> showAddTodoSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (result?.confirmed == true && result?.data != null) {
      _todoService.addTodo(result!.data);
      rebuildUi();
    }
  }

  void toggleTodo(String id) {
    _todoService.toggleTodo(id);
    rebuildUi();
  }

  Future<void> showDeleteDialog(String id) async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (result?.confirmed == true) {
      _todoService.deleteTodo(id);
      rebuildUi();
    }
  }

  void clearCompletedTodos() {
    _todoService.clearCompletedTodos();
    rebuildUi();
  }
}

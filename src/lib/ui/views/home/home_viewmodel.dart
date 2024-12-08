import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _todoService = locator<TodoService>();

  List<TodoItem> get todos => _todoService.todos;

  void showAddTodoSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (result?.confirmed ?? false) {
      rebuildUi();
    }
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    rebuildUi();
  }

  void showDeleteDialog(String id) async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (result?.confirmed ?? false) {
      _todoService.deleteTodo(id);
      rebuildUi();
    }
  }
}

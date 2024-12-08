import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheetModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String _title = '';
  String _description = '';

  String get title => _title;
  String get description => _description;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  bool get canSave => _title.isNotEmpty && _description.isNotEmpty;

  void saveTodo() {
    if (!canSave) return;

    final todo = TodoItem(
      id: DateTime.now().toIso8601String(),
      title: _title,
      description: _description,
      createdAt: DateTime.now(),
    );

    _todoService.addTodo(todo);
    _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
  }
}

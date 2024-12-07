import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/services/todo_service.dart';

class AddTodoSheetModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  String _title = '';
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;
  bool get canSubmit => _title.isNotEmpty && !_isSubmitting;

  void setTitle(String value) {
    _title = value.trim();
    notifyListeners();
  }

  Future<void> submitTodo() async {
    if (!canSubmit) return;

    _isSubmitting = true;
    notifyListeners();

    try {
      await _todoService.createTodo(_title);
      return;
    } catch (e) {
      setError(e.toString());
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}

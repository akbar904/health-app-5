import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class TodoViewModel extends StreamViewModel<List<TodoItem>> {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  bool? _currentFilter;

  @override
  Stream<List<TodoItem>> get stream => _todoService.todosStream;

  List<TodoItem> get filteredTodos =>
      _todoService.filterTodos(isCompleted: _currentFilter);

  void addTodo(String title, String description) {
    final todo = TodoItem(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    _todoService.addTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      dialogPriority: DialogPriority.high,
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
    }
  }

  void toggleTodoComplete(String id) {
    _todoService.toggleTodoComplete(id);
  }

  void setFilter(bool? filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void clearFilter() {
    _currentFilter = null;
    notifyListeners();
  }
}

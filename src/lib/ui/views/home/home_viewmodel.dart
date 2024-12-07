import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:gyde_app/utils/todo_filter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  TodoFilter _currentFilter = TodoFilter.all;
  TodoFilter get currentFilter => _currentFilter;

  List<TodoItem> get filteredTodos =>
      _todoService.getFilteredTodos(_currentFilter);

  void setFilter(TodoFilter filter) {
    _currentFilter = filter;
    rebuildUi();
  }

  Future<void> addTodo() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = response!.data as TodoItem;
      _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  Future<void> editTodo(TodoItem todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: todo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final updatedTodo = response!.data as TodoItem;
      _todoService.updateTodo(updatedTodo);
      rebuildUi();
    }
  }

  void toggleTodoComplete(TodoItem todo) {
    _todoService.toggleTodoComplete(todo.id);
    rebuildUi();
  }
}

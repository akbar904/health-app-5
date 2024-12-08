import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends StreamViewModel<List<Todo>> {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool? _filterCompleted;
  String _searchQuery = '';

  List<Todo> get filteredTodos => _todoService.filterTodos(
        isCompleted: _filterCompleted,
        searchQuery: _searchQuery,
      );

  @override
  Stream<List<Todo>> get stream => _todoService.todosStream;

  Future<void> showAddTodoDialog() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );
  }

  Future<void> showEditTodoDialog(Todo todo) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: todo,
    );
  }

  Future<void> showDeleteTodoDialog(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete "${todo.title}"?',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(todo.id);
    }
  }

  void toggleTodoComplete(String id) {
    _todoService.toggleTodoComplete(id);
  }

  Future<void> showFilterBottomSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoFilter,
      data: _filterCompleted,
    );

    if (response != null) {
      _filterCompleted = response.data;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}

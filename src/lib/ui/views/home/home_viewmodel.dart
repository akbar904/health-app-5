import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool? _selectedFilter;
  bool? get selectedFilter => _selectedFilter;

  List<Todo> get filteredTodos =>
      _todoService.getFilteredTodos(isCompleted: _selectedFilter);

  void setFilter(bool? filter) {
    _selectedFilter = filter;
    rebuildUi();
  }

  Future<void> showAddTodo() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
      title: 'Add Todo',
      description: 'Add a new todo item',
    );

    if (result?.confirmed == true && result?.data != null) {
      final todo = Todo(
        id: const Uuid().v4(),
        title: result!.data['title'],
        description: result.data['description'],
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
    }
  }

  void showTodoDetails(String todoId) async {
    final todo = _todoService.todos.firstWhere((t) => t.id == todoId);
    await _dialogService.showCustomDialog(
      variant: DialogType.taskDetails,
      data: todo,
    );
  }

  void showDeleteConfirmation(String todoId) async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (result?.confirmed == true) {
      _todoService.deleteTodo(todoId);
    }
  }

  void toggleTodoCompletion(String todoId) {
    _todoService.toggleTodoCompletion(todoId);
  }
}

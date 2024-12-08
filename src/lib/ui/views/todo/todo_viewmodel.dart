import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:gyde_app/utils/enums/todo_filter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends StreamViewModel<List<Todo>> {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  TodoFilter _currentFilter = TodoFilter.all;
  TodoFilter get currentFilter => _currentFilter;

  @override
  Stream<List<Todo>> get stream => _todoService.todosStream;

  List<Todo> get todos => data ?? [];
  List<Todo> get filteredTodos {
    switch (_currentFilter) {
      case TodoFilter.active:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodoFilter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      default:
        return todos;
    }
  }

  int get totalTodos => todos.length;
  int get completedTodos => todos.where((todo) => todo.isCompleted).length;

  void setFilter(TodoFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    _todoService.toggleTodoStatus(id);
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
  }

  Future<void> showAddDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed ?? false) {
      final dialogData = response?.data as Map<String, dynamic>;
      _todoService.addTodo(
        dialogData['title'],
        dialogData['description'],
        dialogData['priority'],
      );
    }
  }

  Future<void> showEditDialog(String id) async {
    final todoToEdit = todos.firstWhere((todo) => todo.id == id);

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: todoToEdit,
    );

    if (response?.confirmed ?? false) {
      final updatedTodo = response?.data as Todo;
      _todoService.updateTodo(updatedTodo);
    }
  }
}

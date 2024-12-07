import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> initialize() async {
    await runBusyFuture(loadTodos());
  }

  Future<void> loadTodos() async {
    try {
      _todos = await _todoService.getTodos();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    try {
      final updatedTodo = await _todoService.toggleTodoComplete(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updatedTodo;
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> showDeleteDialog(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      await deleteTodo(todo);
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await _todoService.deleteTodo(todo.id);
      _todos.removeWhere((t) => t.id == todo.id);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> showAddTodoSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (response?.confirmed ?? false) {
      await loadTodos();
    }
  }
}

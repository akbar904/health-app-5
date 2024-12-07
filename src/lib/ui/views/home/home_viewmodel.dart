import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  List<Todo> get todos => _todoService.todos;

  Future<void> showAddTodoDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final data = response!.data as Map<String, dynamic>;
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: data['title'] as String,
        description: data['description'] as String,
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(newTodo);
    }
  }

  void toggleTodoComplete(String id) {
    _todoService.toggleTodoComplete(id);
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
  }

  void navigateToDetail(String id) {
    _navigationService.navigateToTodoDetailView(todoId: id);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_todoService];
}

import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoDetailViewModel extends ReactiveViewModel {
  final String todoId;
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();

  TodoDetailViewModel(this.todoId);

  Todo? get todo => _todoService.getTodoById(todoId);

  void toggleComplete() {
    _todoService.toggleTodoComplete(todoId);
  }

  void deleteTodo() {
    _todoService.deleteTodo(todoId);
    _navigationService.back();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_todoService];
}

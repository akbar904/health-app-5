import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Todo> get todos => _todoService.todos;

  void initialize() {
    _todoService.addListener(_onTodosChanged);
  }

  void _onTodosChanged() {
    rebuildUi();
  }

  void navigateToAddTodo() {
    _navigationService.navigateToAddTodoView();
  }

  void navigateToDetail(Todo todo) {
    _navigationService.navigateToTodoDetailView(todo: todo);
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
  }

  Future<void> showDeleteDialog(Todo todo) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete "${todo.title}"?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(todo.id);
    }
  }

  void showFilterBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoFilter,
    );
  }

  @override
  void dispose() {
    _todoService.removeListener(_onTodosChanged);
    super.dispose();
  }
}

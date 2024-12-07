import 'package:gyde_app/models/todo.dart';

class TodoUtils {
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static List<Todo> sortTodosByDate(List<Todo> todos) {
    final sortedTodos = List<Todo>.from(todos);
    sortedTodos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedTodos;
  }

  static List<Todo> filterTodosByCompletion(
      List<Todo> todos, bool isCompleted) {
    return todos.where((todo) => todo.isCompleted == isCompleted).toList();
  }

  static int getCompletedCount(List<Todo> todos) {
    return todos.where((todo) => todo.isCompleted).length;
  }

  static double getCompletionPercentage(List<Todo> todos) {
    if (todos.isEmpty) return 0.0;
    return (getCompletedCount(todos) / todos.length) * 100;
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/ui/views/todo/todo_viewmodel.dart';
import 'package:gyde_app/ui/common/todo_item.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: kcPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final result = await showModalBottomSheet(
                context: context,
                builder: (context) => const TodoFilterSheet(),
              );
              if (result != null) {
                viewModel.updateFilter(
                  result['showCompleted'],
                  result['showIncomplete'],
                );
              }
            },
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggleComplete: () => viewModel.toggleTodoComplete(todo.id),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                  onEdit: () => viewModel.editTodo(todo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        onPressed: viewModel.navigateToAddTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();

  @override
  void onViewModelReady(TodoViewModel viewModel) => viewModel.initialize();
}

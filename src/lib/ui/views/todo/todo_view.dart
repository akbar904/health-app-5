import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/views/todo/todo_viewmodel.dart';
import 'package:gyde_app/ui/views/todo/widgets/add_todo_button.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_list.dart';
import 'package:stacked/stacked.dart';

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
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (viewModel.hasError)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${viewModel.modelError}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                Expanded(
                  child: TodoList(
                    todos: viewModel.todos,
                    onToggle: viewModel.toggleTodo,
                    onDelete: viewModel.showDeleteDialog,
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
      floatingActionButton: AddTodoButton(
        onPressed: viewModel.showAddTodoSheet,
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();

  @override
  void onViewModelReady(TodoViewModel viewModel) => viewModel.initialize();
}

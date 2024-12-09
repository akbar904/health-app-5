import 'package:flutter/material.dart';
import 'package:gyde_app/features/todo/todo_viewmodel.dart';
import 'package:gyde_app/features/todo/widgets/todo_filters.dart';
import 'package:gyde_app/features/todo/widgets/todo_input.dart';
import 'package:gyde_app/features/todo/widgets/todo_list.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({super.key});

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
      body: Column(
        children: [
          TodoFilters(viewModel: viewModel),
          verticalSpaceSmall,
          TodoInput(
            onSubmit: viewModel.addTodo,
          ),
          verticalSpaceSmall,
          Expanded(
            child: TodoList(
              todos: viewModel.todos,
              onToggle: viewModel.toggleTodoStatus,
              onDelete: viewModel.deleteTodo,
              onEdit: viewModel.updateTodo,
            ),
          ),
        ],
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();

  @override
  void onViewModelReady(TodoViewModel viewModel) => viewModel.initialize();
}

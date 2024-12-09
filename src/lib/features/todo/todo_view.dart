import 'package:flutter/material.dart';
import 'package:gyde_app/features/todo/todo_viewmodel.dart';
import 'package:gyde_app/features/todo/widgets/todo_filter.dart';
import 'package:gyde_app/features/todo/widgets/todo_input.dart';
import 'package:gyde_app/features/todo/widgets/todo_list.dart';
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
      body: Column(
        children: [
          TodoInput(
            onSubmit: (title, description) {
              viewModel.addTodo(title, description);
            },
          ),
          TodoFilter(
            currentFilter: viewModel.filter,
            onFilterChanged: viewModel.setFilter,
          ),
          Expanded(
            child: TodoList(
              todos: viewModel.filteredTodos,
              onToggle: viewModel.toggleTodo,
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

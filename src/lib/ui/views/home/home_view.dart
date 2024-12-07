import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/home_viewmodel.dart';
import 'package:gyde_app/ui/widgets/empty_state.dart';
import 'package:gyde_app/ui/widgets/todo_list.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: kcPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services),
            onPressed: viewModel.clearCompletedTodos,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: ${viewModel.totalTodos} | Completed: ${viewModel.completedTodos} | Pending: ${viewModel.pendingTodos}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: viewModel.todos.isEmpty
                ? const EmptyState(
                    message: 'No todos yet!\nTap + to add a new todo',
                  )
                : TodoList(
                    todos: viewModel.todos,
                    onToggle: viewModel.toggleTodo,
                    onDelete: viewModel.showDeleteDialog,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        onPressed: viewModel.showAddTodoSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

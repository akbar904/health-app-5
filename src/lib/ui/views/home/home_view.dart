import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/home_viewmodel.dart';
import 'package:gyde_app/ui/widgets/empty_state_widget.dart';
import 'package:gyde_app/ui/widgets/todo_item_widget.dart';
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
        title: const Text('Todo List'),
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: viewModel.todos.isEmpty
          ? EmptyStateWidget(
              message: 'No todos yet.\nTap the + button to add one!',
              onActionPressed: viewModel.showAddTodoSheet,
              actionLabel: 'Add Todo',
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItemWidget(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodoCompletion(todo.id),
                  onDelete: () => viewModel.showDeleteDialog(todo.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoSheet,
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

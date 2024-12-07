import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/home_viewmodel.dart';
import 'package:gyde_app/ui/widgets/empty_state.dart';
import 'package:gyde_app/ui/widgets/todo_item.dart';
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
      ),
      body: viewModel.todos.isEmpty
          ? const EmptyState(
              message: 'No todos yet.\nTap the + button to add one!',
              icon: Icons.note_add,
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onTap: () => viewModel.navigateToDetail(todo.id),
                  onToggleComplete: () => viewModel.toggleTodoComplete(todo.id),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoDialog,
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

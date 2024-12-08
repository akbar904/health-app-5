import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/widgets/todo_item.dart';
import 'package:gyde_app/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.showFilterBottomSheet,
          ),
        ],
      ),
      body: viewModel.todos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.note_add_outlined,
                    size: 64,
                    color: kcMediumGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No todos yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: kcMediumGrey,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onTap: () => viewModel.navigateToDetail(todo),
                  onToggle: () => viewModel.toggleTodoCompletion(todo.id),
                  onDelete: () => viewModel.showDeleteDialog(todo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.navigateToAddTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}

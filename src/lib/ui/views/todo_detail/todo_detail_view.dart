import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/todo_detail/todo_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class TodoDetailView extends StackedView<TodoDetailViewModel> {
  const TodoDetailView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TodoDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: viewModel.deleteTodo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.todo.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Created on ${DateFormat('MMM dd, yyyy - HH:mm').format(viewModel.todo.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: kcMediumGrey,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              viewModel.todo.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text('Status:'),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    viewModel.todo.isCompleted ? 'Completed' : 'Pending',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: viewModel.todo.isCompleted
                      ? kcSuccessColor
                      : kcPrimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.toggleCompletion,
        child: Icon(
          viewModel.todo.isCompleted
              ? Icons.check_box
              : Icons.check_box_outlined,
        ),
      ),
    );
  }

  @override
  TodoDetailViewModel viewModelBuilder(BuildContext context) =>
      TodoDetailViewModel();
}

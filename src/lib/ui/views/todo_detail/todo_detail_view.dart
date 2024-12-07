import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/views/todo_detail/todo_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TodoDetailView extends StackedView<TodoDetailViewModel> {
  final String todoId;

  const TodoDetailView({
    required this.todoId,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    TodoDetailViewModel viewModel,
    Widget? child,
  ) {
    final todo = viewModel.todo;
    if (todo == null) {
      return const Scaffold(
        body: Center(
          child: Text('Todo not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
        backgroundColor: kcPrimaryColor,
        actions: [
          IconButton(
            icon: Icon(
              todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: todo.isCompleted ? Colors.green : Colors.white,
            ),
            onPressed: viewModel.toggleComplete,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: viewModel.deleteTodo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: headlineMediumStyle.copyWith(
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            verticalSpaceMedium,
            Text(
              todo.description,
              style: bodyLargeStyle,
            ),
            verticalSpaceLarge,
            Text(
              'Created on: ${todo.createdAt.day}/${todo.createdAt.month}/${todo.createdAt.year}',
              style: labelMediumStyle.copyWith(color: kcMediumGrey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TodoDetailViewModel viewModelBuilder(BuildContext context) =>
      TodoDetailViewModel(todoId);
}

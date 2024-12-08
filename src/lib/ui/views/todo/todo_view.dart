import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/todo/todo_viewmodel.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_input.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_item.dart';
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
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: Icon(
              viewModel.showCompleted
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            onPressed: viewModel.toggleShowCompleted,
          ),
        ],
      ),
      body: Column(
        children: [
          TodoInput(
            onSubmit: viewModel.addTodo,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.showCompleted
                  ? viewModel.completedTodos.length
                  : viewModel.incompleteTodos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.showCompleted
                    ? viewModel.completedTodos[index]
                    : viewModel.incompleteTodos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: viewModel.toggleTodoStatus,
                  onEdit: viewModel.updateTodoTitle,
                  onDelete: viewModel.deleteTodo,
                );
              },
            ),
          ),
          if (viewModel.completedTodos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: viewModel.clearCompleted,
                child: const Text('Clear Completed'),
              ),
            ),
        ],
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}

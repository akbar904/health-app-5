import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/todo_viewmodel.dart';
import 'package:gyde_app/ui/widgets/add_todo_fab.dart';
import 'package:gyde_app/ui/widgets/empty_todo_placeholder.dart';
import 'package:gyde_app/ui/widgets/todo_count.dart';
import 'package:gyde_app/ui/widgets/todo_filter.dart';
import 'package:gyde_app/ui/widgets/todo_list.dart';
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
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const TodoCount(),
          const TodoFilter(),
          Expanded(
            child: viewModel.todos.isEmpty
                ? const EmptyTodoPlaceholder()
                : const TodoList(),
          ),
        ],
      ),
      floatingActionButton: const AddTodoFAB(),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}

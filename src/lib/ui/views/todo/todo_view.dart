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
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          TodoInput(
            onChanged: viewModel.updateSearchQuery,
            onSubmitted: (_) => viewModel.showAddTodoDialog(),
          ),
          Expanded(
            child: viewModel.filteredTodos.isEmpty
                ? const Center(
                    child: Text('No todos found'),
                  )
                : ListView.builder(
                    itemCount: viewModel.filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = viewModel.filteredTodos[index];
                      return TodoItem(
                        todo: todo,
                        onToggle: viewModel.toggleTodoComplete,
                        onEdit: viewModel.showEditTodoDialog,
                        onDelete: viewModel.showDeleteTodoDialog,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoDialog,
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/views/todo/todo_viewmodel.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_item_widget.dart';
import 'package:gyde_app/ui/views/todo/widgets/add_todo_dialog.dart';

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
            onPressed: () => _showFilterDialog(context, viewModel),
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.filteredTodos[index];
                return TodoItemWidget(
                  todo: todo,
                  onDelete: viewModel.deleteTodo,
                  onToggleComplete: viewModel.toggleTodoComplete,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, viewModel),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, TodoViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(
        onAdd: viewModel.addTodo,
      ),
    );
  }

  void _showFilterDialog(BuildContext context, TodoViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All'),
              onTap: () {
                viewModel.clearFilter();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Completed'),
              onTap: () {
                viewModel.setFilter(true);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Incomplete'),
              onTap: () {
                viewModel.setFilter(false);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}

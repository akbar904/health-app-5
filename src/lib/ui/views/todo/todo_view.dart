import 'package:flutter/material.dart';
import 'package:gyde_app/ui/views/todo/todo_viewmodel.dart';
import 'package:gyde_app/ui/views/todo/widgets/empty_todo.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_filter.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_list.dart';
import 'package:gyde_app/ui/views/todo/widgets/todo_stats.dart';
import 'package:stacked/stacked.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TodoStats(
            totalTodos: viewModel.totalTodos,
            completedTodos: viewModel.completedTodos,
          ),
          TodoFilter(
            selectedFilter: viewModel.currentFilter,
            onFilterSelected: viewModel.setFilter,
          ),
          Expanded(
            child: viewModel.todos.isEmpty
                ? const EmptyTodo()
                : TodoList(
                    todos: viewModel.filteredTodos,
                    onToggle: viewModel.toggleTodoStatus,
                    onEdit: viewModel.showEditDialog,
                    onDelete: viewModel.deleteTodo,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}

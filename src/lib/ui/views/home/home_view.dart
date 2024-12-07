import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/views/home/home_viewmodel.dart';
import 'package:gyde_app/ui/widgets/add_todo_fab.dart';
import 'package:gyde_app/ui/widgets/todo_list_widget.dart';
import 'package:gyde_app/utils/todo_filter.dart';
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
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
        actions: [
          PopupMenuButton<TodoFilter>(
            onSelected: viewModel.setFilter,
            itemBuilder: (context) => TodoFilter.values
                .map(
                  (filter) => PopupMenuItem(
                    value: filter,
                    child: Text(
                      filter.displayName,
                      style: bodyMediumStyle.copyWith(
                        fontWeight: filter == viewModel.currentFilter
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: TodoListWidget(
        todos: viewModel.filteredTodos,
        onTodoTap: viewModel.editTodo,
        onToggleComplete: viewModel.toggleTodoComplete,
      ),
      floatingActionButton: AddTodoFab(
        onPressed: viewModel.addTodo,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

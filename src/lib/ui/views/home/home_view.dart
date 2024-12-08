import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/views/home/home_viewmodel.dart';
import 'package:gyde_app/ui/widgets/todo_filter.dart';
import 'package:gyde_app/ui/widgets/todo_list.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: headlineSmallStyle.copyWith(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TodoFilter(
              selectedFilter: viewModel.selectedFilter,
              onFilterChanged: viewModel.setFilter,
            ),
          ),
          Expanded(
            child: TodoList(
              todos: viewModel.filteredTodos,
              onTodoTap: viewModel.showTodoDetails,
              onDeleteTodo: viewModel.showDeleteConfirmation,
              onToggleTodo: viewModel.toggleTodoCompletion,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodo,
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

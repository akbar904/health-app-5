import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/todo_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TodoFilter extends ViewModelWidget<TodoViewModel> {
  const TodoFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilterChip(
            selected: viewModel.currentFilter == 'all',
            onSelected: (_) => viewModel.setFilter('all'),
            label: const Text('All'),
            backgroundColor: kcVeryLightGrey,
            selectedColor: kcTodoColor,
          ),
          const SizedBox(width: 10),
          FilterChip(
            selected: viewModel.currentFilter == 'active',
            onSelected: (_) => viewModel.setFilter('active'),
            label: const Text('Active'),
            backgroundColor: kcVeryLightGrey,
            selectedColor: kcTodoColor,
          ),
          const SizedBox(width: 10),
          FilterChip(
            selected: viewModel.currentFilter == 'completed',
            onSelected: (_) => viewModel.setFilter('completed'),
            label: const Text('Completed'),
            backgroundColor: kcVeryLightGrey,
            selectedColor: kcTodoColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gyde_app/features/todo/todo_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoFilters extends StatelessWidget {
  final TodoViewModel viewModel;

  const TodoFilters({
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilterChip(
          label: const Text('All'),
          selected: viewModel.currentFilter == TodoFilter.all,
          onSelected: (_) => viewModel.setFilter(TodoFilter.all),
          backgroundColor: kcVeryLightGrey,
          selectedColor: kcPrimaryColor,
        ),
        FilterChip(
          label: const Text('Active'),
          selected: viewModel.currentFilter == TodoFilter.active,
          onSelected: (_) => viewModel.setFilter(TodoFilter.active),
          backgroundColor: kcVeryLightGrey,
          selectedColor: kcPrimaryColor,
        ),
        FilterChip(
          label: const Text('Completed'),
          selected: viewModel.currentFilter == TodoFilter.completed,
          onSelected: (_) => viewModel.setFilter(TodoFilter.completed),
          backgroundColor: kcVeryLightGrey,
          selectedColor: kcPrimaryColor,
        ),
      ],
    );
  }
}

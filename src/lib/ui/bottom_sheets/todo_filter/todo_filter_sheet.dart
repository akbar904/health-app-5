import 'package:flutter/material.dart';
import 'package:gyde_app/ui/bottom_sheets/todo_filter/todo_filter_sheet_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFilterSheet extends StackedView<TodoFilterSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const TodoFilterSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoFilterSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Filter Todos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: Radio<TodoFilter>(
              value: TodoFilter.all,
              groupValue: viewModel.selectedFilter,
              onChanged: viewModel.setFilter,
            ),
            title: const Text('All'),
            onTap: () => viewModel.setFilter(TodoFilter.all),
          ),
          ListTile(
            leading: Radio<TodoFilter>(
              value: TodoFilter.completed,
              groupValue: viewModel.selectedFilter,
              onChanged: viewModel.setFilter,
            ),
            title: const Text('Completed'),
            onTap: () => viewModel.setFilter(TodoFilter.completed),
          ),
          ListTile(
            leading: Radio<TodoFilter>(
              value: TodoFilter.pending,
              groupValue: viewModel.selectedFilter,
              onChanged: viewModel.setFilter,
            ),
            title: const Text('Pending'),
            onTap: () => viewModel.setFilter(TodoFilter.pending),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.applyFilter,
            style: ElevatedButton.styleFrom(
              backgroundColor: kcPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Apply Filter'),
          ),
        ],
      ),
    );
  }

  @override
  TodoFilterSheetModel viewModelBuilder(BuildContext context) =>
      TodoFilterSheetModel(completer);
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'todo_filter_sheet_model.dart';

class TodoFilterSheet extends StackedView<TodoFilterSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const TodoFilterSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoFilterSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter Todos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceMedium,
          RadioListTile<bool>(
            title: const Text('All'),
            value: null,
            groupValue: viewModel.selectedFilter,
            onChanged: viewModel.setFilter,
          ),
          RadioListTile<bool>(
            title: const Text('Completed'),
            value: true,
            groupValue: viewModel.selectedFilter,
            onChanged: viewModel.setFilter,
          ),
          RadioListTile<bool>(
            title: const Text('Incomplete'),
            value: false,
            groupValue: viewModel.selectedFilter,
            onChanged: viewModel.setFilter,
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: viewModel.clearFilter,
                child: const Text('Clear'),
              ),
              horizontalSpaceSmall,
              ElevatedButton(
                onPressed: viewModel.applyFilter,
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  TodoFilterSheetModel viewModelBuilder(BuildContext context) =>
      TodoFilterSheetModel(completer: completer!);
}

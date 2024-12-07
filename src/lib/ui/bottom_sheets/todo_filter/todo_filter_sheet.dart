import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/ui/bottom_sheets/todo_filter/todo_filter_sheet_model.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Todos',
            style: Theme.of(context).textTheme.headline6,
          ),
          verticalSpaceMedium,
          CheckboxListTile(
            title: const Text('Show Completed'),
            value: viewModel.showCompleted,
            onChanged: (_) => viewModel.toggleCompleted(),
          ),
          CheckboxListTile(
            title: const Text('Show Incomplete'),
            value: viewModel.showIncomplete,
            onChanged: (_) => viewModel.toggleIncomplete(),
          ),
          verticalSpaceMedium,
          ElevatedButton(
            onPressed: () => completer?.call(
              SheetResponse(
                confirmed: true,
                data: {
                  'showCompleted': viewModel.showCompleted,
                  'showIncomplete': viewModel.showIncomplete,
                },
              ),
            ),
            child: const Text('Apply Filter'),
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }

  @override
  TodoFilterSheetModel viewModelBuilder(BuildContext context) =>
      TodoFilterSheetModel();
}

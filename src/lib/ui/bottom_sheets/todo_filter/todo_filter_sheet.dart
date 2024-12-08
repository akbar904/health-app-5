import 'package:flutter/material.dart';
import 'package:gyde_app/ui/bottom_sheets/todo_filter/todo_filter_sheet_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFilterSheet extends StackedView<TodoFilterSheetModel> {
  final Function(SheetResponse) completer;
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Todos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          RadioListTile<bool?>(
            title: const Text('All'),
            value: null,
            groupValue: request.data as bool?,
            onChanged: (value) => completer(SheetResponse(data: value)),
          ),
          RadioListTile<bool?>(
            title: const Text('Completed'),
            value: true,
            groupValue: request.data as bool?,
            onChanged: (value) => completer(SheetResponse(data: value)),
          ),
          RadioListTile<bool?>(
            title: const Text('Incomplete'),
            value: false,
            groupValue: request.data as bool?,
            onChanged: (value) => completer(SheetResponse(data: value)),
          ),
        ],
      ),
    );
  }

  @override
  TodoFilterSheetModel viewModelBuilder(BuildContext context) =>
      TodoFilterSheetModel();
}

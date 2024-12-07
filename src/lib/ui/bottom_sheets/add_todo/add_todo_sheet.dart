import 'package:flutter/material.dart';
import 'package:gyde_app/ui/bottom_sheets/add_todo/add_todo_sheet_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StackedView<AddTodoSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const AddTodoSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddTodoSheetModel viewModel,
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
            'Add New Todo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: viewModel.todoController,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kcPrimaryColor),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    completer?.call(SheetResponse(confirmed: false)),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                ),
                onPressed: () => viewModel.saveTodo(completer),
                child: const Text('Add Todo'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  AddTodoSheetModel viewModelBuilder(BuildContext context) =>
      AddTodoSheetModel();
}

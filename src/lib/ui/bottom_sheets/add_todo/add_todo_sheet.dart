import 'package:flutter/material.dart';
import 'package:gyde_app/ui/bottom_sheets/add_todo/add_todo_sheet_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StackedView<AddTodoSheetModel> {
  final Function(SheetResponse)? completer;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Todo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
              border: OutlineInputBorder(),
            ),
            onChanged: viewModel.setTitle,
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
                onPressed: viewModel.canSubmit
                    ? () async {
                        await viewModel.submitTodo();
                        completer?.call(SheetResponse(confirmed: true));
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                ),
                child: viewModel.isSubmitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
          if (viewModel.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                viewModel.modelError,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  @override
  AddTodoSheetModel viewModelBuilder(BuildContext context) =>
      AddTodoSheetModel();
}

import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/dialogs/add_todo/add_todo_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoDialog extends StackedView<AddTodoDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddTodoDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddTodoDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Todo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpaceMedium,
            TextField(
              controller: viewModel.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            verticalSpaceSmall,
            TextField(
              controller: viewModel.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                  ),
                  onPressed: () => viewModel.submit(completer),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddTodoDialogModel viewModelBuilder(BuildContext context) =>
      AddTodoDialogModel();
}

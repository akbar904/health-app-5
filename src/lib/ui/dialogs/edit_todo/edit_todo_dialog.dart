import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/ui/dialogs/edit_todo/edit_todo_dialog_model.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class EditTodoDialog extends StackedView<EditTodoDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EditTodoDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditTodoDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Todo',
              style: Theme.of(context).textTheme.headline6,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                horizontalSpaceSmall,
                ElevatedButton(
                  onPressed: () => viewModel.updateTodo(completer),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  EditTodoDialogModel viewModelBuilder(BuildContext context) =>
      EditTodoDialogModel(request.data as Todo);
}

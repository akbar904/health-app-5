import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_item.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/dialogs/edit_todo/edit_todo_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditTodoDialog extends StackedView<EditTodoDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EditTodoDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditTodoDialogModel viewModel,
    Widget? child,
  ) {
    final todo = request.data as TodoItem;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Todo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpaceMedium,
            TextField(
              controller: viewModel.titleController..text = todo.title,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            verticalSpaceSmall,
            TextField(
              controller: viewModel.descriptionController
                ..text = todo.description,
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
                  onPressed: () => completer(
                    DialogResponse(
                      confirmed: true,
                      data: todo.copyWith(
                        title: viewModel.titleController.text,
                        description: viewModel.descriptionController.text,
                      ),
                    ),
                  ),
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
      EditTodoDialogModel();
}

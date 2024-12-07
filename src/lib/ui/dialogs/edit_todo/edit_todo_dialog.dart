import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/dialogs/edit_todo/edit_todo_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
    final todo = request.data as TodoModel;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Todo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: viewModel.titleController..text = todo.title,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                errorText: null,
              ),
              onChanged: viewModel.onTitleChanged,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.descriptionController
                ..text = todo.description,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: viewModel.onDescriptionChanged,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: kcMediumGrey),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: viewModel.canSubmit
                      ? () => completer(
                            DialogResponse(
                              confirmed: true,
                              data: todo.copyWith(
                                title: viewModel.titleController.text,
                                description:
                                    viewModel.descriptionController.text,
                              ),
                            ),
                          )
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcTodoColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Changes'),
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

  @override
  void onDispose(EditTodoDialogModel viewModel) {
    super.onDispose(viewModel);
    viewModel.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/dialogs/todo_edit/todo_edit_dialog_model.dart';
import 'package:stacked/stacked.dart';

class TodoEditDialog extends StatelessWidget {
  final String initialTitle;
  final String initialDescription;

  const TodoEditDialog({
    Key? key,
    required this.initialTitle,
    required this.initialDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoEditDialogModel>.reactive(
      viewModelBuilder: () => TodoEditDialogModel(),
      builder: (context, model, child) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: initialTitle)
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: initialTitle.length),
                  ),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: model.setTitle,
              ),
              verticalSpaceMedium,
              TextField(
                controller: TextEditingController(text: initialDescription)
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: initialDescription.length),
                  ),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: model.setDescription,
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  horizontalSpaceSmall,
                  ElevatedButton(
                    onPressed: model.canSave
                        ? () => Navigator.of(context).pop({
                              'title': model.title,
                              'description': model.description,
                            })
                        : null,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

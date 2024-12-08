import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/dialogs/add_todo/add_todo_dialog_model.dart';
import 'package:gyde_app/utils/enums/todo_priority.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Todo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: viewModel.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TodoPriority>(
              value: viewModel.selectedPriority,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: TodoPriority.values.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Row(
                    children: [
                      Text(priority.emoji),
                      const SizedBox(width: 8),
                      Text(priority.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: viewModel.setPriority,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => viewModel.addTodo(completer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                  ),
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

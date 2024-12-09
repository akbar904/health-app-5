import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoEditDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TodoEditDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  State<TodoEditDialog> createState() => _TodoEditDialogState();
}

class _TodoEditDialogState extends State<TodoEditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final Todo? todo = widget.request.data;
    _titleController = TextEditingController(text: todo?.title ?? '');
    _descriptionController =
        TextEditingController(text: todo?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.request.title ?? 'Edit Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            verticalSpaceSmall,
            TextField(
              controller: _descriptionController,
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
                  onPressed: () =>
                      widget.completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                horizontalSpaceSmall,
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.trim().isEmpty) {
                      return;
                    }
                    final todoData = {
                      'title': _titleController.text.trim(),
                      'description': _descriptionController.text.trim(),
                    };
                    widget.completer(
                      DialogResponse(
                        confirmed: true,
                        data: todoData,
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

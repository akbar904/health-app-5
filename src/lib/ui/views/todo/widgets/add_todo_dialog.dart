import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(String title, String description) onAdd;

  const AddTodoDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              verticalSpaceMedium,
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  horizontalSpaceSmall,
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onAdd(
                          _titleController.text,
                          _descriptionController.text,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
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

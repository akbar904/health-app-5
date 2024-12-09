import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class TodoInput extends StatefulWidget {
  final Function(String, String) onSubmit;

  const TodoInput({
    required this.onSubmit,
    super.key,
  });

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTodo() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty) {
      widget.onSubmit(title, description);
      _titleController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Add a new todo',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submitTodo(),
          ),
          verticalSpaceSmall,
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description (optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          verticalSpaceSmall,
          ElevatedButton(
            onPressed: _submitTodo,
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}

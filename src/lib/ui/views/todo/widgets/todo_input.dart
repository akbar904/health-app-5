import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoInput extends StatelessWidget {
  final Function(String) onSubmit;

  const TodoInput({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Add a new todo...',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  onSubmit(value);
                  textController.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onSubmit(textController.text);
                textController.clear();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

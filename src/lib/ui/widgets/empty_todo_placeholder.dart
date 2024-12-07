import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class EmptyTodoPlaceholder extends StatelessWidget {
  const EmptyTodoPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: kcTodoColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No todos yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kcMediumGrey.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a new todo to get started',
            style: TextStyle(
              fontSize: 16,
              color: kcMediumGrey.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

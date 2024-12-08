import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class EmptyTodo extends StatelessWidget {
  const EmptyTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 80,
            color: kcPrimaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No todos yet!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kcMediumGrey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a new todo to get started',
            style: TextStyle(
              color: kcLightGrey,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class AddTodoFab extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTodoFab({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: kcPrimaryColor,
      child: const Icon(Icons.add),
    );
  }
}

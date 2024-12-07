import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class AddTodoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTodoButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: kcPrimaryColor,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

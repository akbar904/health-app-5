import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    required this.message,
    this.icon = Icons.inbox_outlined,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: kcMediumGrey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: bodyLargeStyle.copyWith(
              color: kcMediumGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

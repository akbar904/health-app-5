import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    required this.message,
    this.icon = Icons.hourglass_empty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 48,
            color: kcMediumGrey,
          ),
          verticalSpaceMedium,
          Text(
            message,
            style: bodyLargeStyle.copyWith(color: kcMediumGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

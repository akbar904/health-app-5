import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.message,
    this.onActionPressed,
    this.actionLabel,
  });

  final String message;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 64,
            color: kcMediumGrey,
          ),
          const Gap(16),
          Text(
            message,
            style: bodyLargeStyle.copyWith(color: kcMediumGrey),
            textAlign: TextAlign.center,
          ),
          if (onActionPressed != null && actionLabel != null) ...[
            const Gap(16),
            TextButton(
              onPressed: onActionPressed,
              child: Text(
                actionLabel!,
                style: titleMediumStyle.copyWith(color: kcPrimaryColor),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

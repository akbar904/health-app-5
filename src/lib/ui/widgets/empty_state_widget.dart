import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: kcPrimaryColor.withOpacity(0.5),
          ),
          verticalSpaceMedium,
          Text(
            'No todos yet!',
            style: headlineSmallStyle.copyWith(
              color: kcMediumGrey,
            ),
          ),
          verticalSpaceSmall,
          const Text(
            'Add a new todo using the + button below',
            style: bodyMediumStyle,
          ),
        ],
      ),
    );
  }
}

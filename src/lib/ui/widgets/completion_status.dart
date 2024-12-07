import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/utils/todo_utils.dart';

class CompletionStatus extends StatelessWidget {
  final List<dynamic> todos;

  const CompletionStatus({
    required this.todos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final completionPercentage = TodoUtils.getCompletionPercentage(todos);
    final completedCount = TodoUtils.getCompletedCount(todos);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Progress',
            style: titleMediumStyle.copyWith(
              color: kcPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: completionPercentage / 100,
            backgroundColor: kcVeryLightGrey,
            valueColor: const AlwaysStoppedAnimation<Color>(kcPrimaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedCount of ${todos.length} tasks completed',
            style: bodySmallStyle.copyWith(color: kcMediumGrey),
          ),
        ],
      ),
    );
  }
}

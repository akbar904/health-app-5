import 'package:flutter/material.dart';
import 'package:gyde_app/models/todo.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/dialogs/task_details/task_details_dialog_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TaskDetailsDialog extends StackedView<TaskDetailsDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TaskDetailsDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaskDetailsDialogModel viewModel,
    Widget? child,
  ) {
    final todo = request.data as Todo;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Details',
                  style: headlineSmallStyle,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                ),
              ],
            ),
            verticalSpaceMedium,
            Text(
              todo.title,
              style: titleLargeStyle,
            ),
            verticalSpaceSmall,
            Text(
              todo.description,
              style: bodyMediumStyle,
            ),
            verticalSpaceMedium,
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: kcMediumGrey),
                horizontalSpaceSmall,
                Text(
                  'Created: ${DateFormat.yMMMMd().format(todo.createdAt)}',
                  style: labelMediumStyle,
                ),
              ],
            ),
            if (todo.isCompleted && todo.completedAt != null) ...[
              verticalSpaceSmall,
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Colors.green),
                  horizontalSpaceSmall,
                  Text(
                    'Completed: ${DateFormat.yMMMMd().format(todo.completedAt!)}',
                    style: labelMediumStyle,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  TaskDetailsDialogModel viewModelBuilder(BuildContext context) =>
      TaskDetailsDialogModel();
}

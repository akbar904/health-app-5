import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/dialogs/confirm_delete/confirm_delete_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDeleteDialog extends StackedView<ConfirmDeleteDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmDeleteDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConfirmDeleteDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              request.title ?? 'Confirm Delete',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              request.description ??
                  'Are you sure you want to delete this item?',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcErrorColor,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  ConfirmDeleteDialogModel viewModelBuilder(BuildContext context) =>
      ConfirmDeleteDialogModel();
}

import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
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
              style: titleLargeStyle,
            ),
            const SizedBox(height: 16),
            Text(
              request.description ??
                  'Are you sure you want to delete this item?',
              style: bodyMediumStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: Text(
                    'Cancel',
                    style: buttonStyle.copyWith(color: kcMediumGrey),
                  ),
                ),
                ElevatedButton(
                  onPressed: viewModel.isDeleting
                      ? null
                      : () => completer(DialogResponse(confirmed: true)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    viewModel.isDeleting ? 'Deleting...' : 'Delete',
                    style: buttonStyle.copyWith(color: Colors.white),
                  ),
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

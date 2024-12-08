// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import '../ui/dialogs/task_details/task_details_dialog.dart';

enum DialogType {
  taskDetails,
  confirmDelete,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.taskDetails: (context, request, completer) =>
        TaskDetailsDialog(request: request, completer: completer),
    DialogType.confirmDelete: (context, request, completer) =>
        ConfirmDeleteDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../features/todo/dialogs/todo_delete_dialog.dart';
import '../features/todo/dialogs/todo_edit_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

enum DialogType {
  infoAlert,
  todoEdit,
  todoDelete,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.todoEdit: (context, request, completer) =>
        TodoEditDialog(request: request, completer: completer),
    DialogType.todoDelete: (context, request, completer) =>
        TodoDeleteDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

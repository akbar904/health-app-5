// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/filter_dialog/filter_dialog.dart';

enum DialogType {
  filter,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.filter: (context, request, completer) =>
        FilterDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

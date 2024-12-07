import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDeleteDialogModel extends BaseViewModel {
  void confirmDelete(Function(DialogResponse) completer) {
    completer(DialogResponse(confirmed: true));
  }

  void cancel(Function(DialogResponse) completer) {
    completer(DialogResponse(confirmed: false));
  }
}

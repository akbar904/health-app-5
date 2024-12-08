import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDeleteDialogModel extends BaseViewModel {
  void confirm(DialogResponse Function(DialogResponse) completer) {
    completer(DialogResponse(confirmed: true));
  }

  void cancel(DialogResponse Function(DialogResponse) completer) {
    completer(DialogResponse(confirmed: false));
  }
}

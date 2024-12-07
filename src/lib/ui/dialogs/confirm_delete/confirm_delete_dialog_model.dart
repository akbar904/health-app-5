import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDeleteDialogModel extends BaseViewModel {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  ConfirmDeleteDialogModel({
    required this.request,
    required this.completer,
  });

  void confirm() {
    completer(DialogResponse(confirmed: true));
  }

  void cancel() {
    completer(DialogResponse(confirmed: false));
  }
}

import 'package:stacked/stacked.dart';

class ConfirmDeleteDialogModel extends BaseViewModel {
  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  void setDeleting(bool value) {
    _isDeleting = value;
    notifyListeners();
  }
}

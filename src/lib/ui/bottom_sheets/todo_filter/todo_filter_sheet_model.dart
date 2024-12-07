import 'package:stacked/stacked.dart';

class TodoFilterSheetModel extends BaseViewModel {
  bool _showCompleted = true;
  bool _showIncomplete = true;

  bool get showCompleted => _showCompleted;
  bool get showIncomplete => _showIncomplete;

  void toggleCompleted() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  void toggleIncomplete() {
    _showIncomplete = !_showIncomplete;
    notifyListeners();
  }

  void applyFilter(Function(bool showCompleted, bool showIncomplete) onApply) {
    onApply(_showCompleted, _showIncomplete);
  }
}

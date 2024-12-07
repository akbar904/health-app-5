import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFilterSheetModel extends BaseViewModel {
  final Function(SheetResponse) completer;
  bool? _selectedFilter;

  TodoFilterSheetModel({required this.completer});

  bool? get selectedFilter => _selectedFilter;

  void setFilter(bool? value) {
    _selectedFilter = value;
    notifyListeners();
  }

  void applyFilter() {
    completer(SheetResponse(data: _selectedFilter));
  }

  void clearFilter() {
    _selectedFilter = null;
    completer(SheetResponse(data: null));
  }
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum TodoFilter { all, completed, pending }

class TodoFilterSheetModel extends BaseViewModel {
  final Function(SheetResponse)? completer;
  TodoFilter _selectedFilter = TodoFilter.all;

  TodoFilterSheetModel(this.completer);

  TodoFilter get selectedFilter => _selectedFilter;

  void setFilter(TodoFilter? filter) {
    if (filter != null) {
      _selectedFilter = filter;
      rebuildUi();
    }
  }

  void applyFilter() {
    completer?.call(
      SheetResponse(
        confirmed: true,
        data: _selectedFilter,
      ),
    );
  }
}

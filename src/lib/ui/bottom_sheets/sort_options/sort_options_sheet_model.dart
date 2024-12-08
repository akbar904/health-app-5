import 'package:stacked/stacked.dart';
import 'package:gyde_app/services/flight_service.dart';

class SortOptionsSheetModel extends BaseViewModel {
  SortOption _selectedOption = SortOption.priceAscending;
  SortOption get selectedOption => _selectedOption;

  void setOption(SortOption option) {
    _selectedOption = option;
    notifyListeners();
  }
}

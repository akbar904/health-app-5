import 'package:stacked/stacked.dart';

class FilterDialogModel extends BaseViewModel {
  String? _selectedAirline;
  double _maxPrice = 2000;
  bool _isDirectFlightsOnly = false;

  String? get selectedAirline => _selectedAirline;
  double get maxPrice => _maxPrice;
  bool get isDirectFlightsOnly => _isDirectFlightsOnly;

  void setAirline(String? airline) {
    _selectedAirline = airline;
    notifyListeners();
  }

  void setMaxPrice(double price) {
    _maxPrice = price;
    notifyListeners();
  }

  void setDirectFlightsOnly(bool value) {
    _isDirectFlightsOnly = value;
    notifyListeners();
  }

  void resetFilters() {
    _selectedAirline = null;
    _maxPrice = 2000;
    _isDirectFlightsOnly = false;
    notifyListeners();
  }
}

import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/services/flight_service.dart';
import 'package:stacked_services/stacked_services.dart';

class FlightListViewModel extends BaseViewModel {
  final _flightService = locator<FlightService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Flight> _flights = [];
  List<Flight> get flights => _flights;

  String? _selectedAirline;
  double _maxPrice = 2000;
  SortOption _currentSortOption = SortOption.priceAscending;

  void initialize({
    required String departureCity,
    required String arrivalCity,
    required DateTime departureDate,
    required int passengers,
  }) {
    setBusy(true);
    try {
      _flights = _flightService.searchFlights(
        departureCity: departureCity,
        arrivalCity: arrivalCity,
        departureDate: departureDate,
        passengers: passengers,
      );
      _applyFiltersAndSort();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void _applyFiltersAndSort() {
    _flights = _flightService.filterAndSortFlights(
      flights: _flights,
      airline: _selectedAirline,
      maxPrice: _maxPrice,
      sortOption: _currentSortOption,
    );
    notifyListeners();
  }

  Future<void> showFilterDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: 'filter',
      data: {
        'selectedAirline': _selectedAirline,
        'maxPrice': _maxPrice,
      },
    );

    if (response?.confirmed ?? false) {
      _selectedAirline = response?.data['airline'];
      _maxPrice = response?.data['maxPrice'] ?? 2000.0;
      _applyFiltersAndSort();
    }
  }

  Future<void> showSortOptions() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: 'sortOptions',
    );

    if (response?.data != null) {
      _currentSortOption = response!.data;
      _applyFiltersAndSort();
    }
  }

  void navigateToFlightDetails(String flightId) {
    _navigationService.navigateToFlightDetailsView(flightId: flightId);
  }
}

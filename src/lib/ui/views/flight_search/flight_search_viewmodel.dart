import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/services/flight_service.dart';
import 'package:stacked_services/stacked_services.dart';

class FlightSearchViewModel extends BaseViewModel {
  final _flightService = locator<FlightService>();
  final _navigationService = locator<NavigationService>();

  List<String> get availableCities => _flightService.availableCities;

  void searchFlights({
    required String departureCity,
    required String arrivalCity,
    required DateTime departureDate,
    required int passengers,
  }) {
    if (departureCity == arrivalCity) {
      setError('Departure and arrival cities cannot be the same');
      return;
    }

    if (departureDate.isBefore(DateTime.now())) {
      setError('Departure date cannot be in the past');
      return;
    }

    _navigationService.navigateToFlightListView(
      departureCity: departureCity,
      arrivalCity: arrivalCity,
      departureDate: departureDate,
      passengers: passengers,
    );
  }

  bool isValidSearch({
    required String departureCity,
    required String arrivalCity,
    required DateTime? departureDate,
    required int passengers,
  }) {
    return departureCity.isNotEmpty &&
        arrivalCity.isNotEmpty &&
        departureDate != null &&
        passengers > 0 &&
        passengers <= 9;
  }
}

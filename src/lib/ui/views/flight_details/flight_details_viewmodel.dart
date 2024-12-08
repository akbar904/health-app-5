import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/services/flight_service.dart';
import 'package:stacked_services/stacked_services.dart';

class FlightDetailsViewModel extends BaseViewModel {
  final _flightService = locator<FlightService>();
  final _navigationService = locator<NavigationService>();

  late Flight _flight;
  Flight get flight => _flight;

  void initialize(String flightId) {
    final flight = _flightService.getFlightById(flightId);
    if (flight != null) {
      _flight = flight;
      notifyListeners();
    } else {
      _navigationService.back();
    }
  }

  String get formattedDuration {
    final hours = _flight.duration.inHours;
    final minutes = _flight.duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  void navigateToPassengerInfo() {
    _navigationService.navigateToPassengerInfoView(flight: _flight);
  }

  String get formattedPrice => '\$${_flight.price.toStringAsFixed(2)}';

  String get availabilityText => '${_flight.availableSeats} seats available';
}

import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/booking/booking_model.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';
import 'package:gyde_app/services/booking_service.dart';
import 'package:stacked_services/stacked_services.dart';

class BookingSummaryViewModel extends BaseViewModel {
  final _bookingService = locator<BookingService>();
  final _navigationService = locator<NavigationService>();

  late Flight _flight;
  late List<Passenger> _passengers;
  String _contactEmail = '';
  String _contactPhone = '';

  Flight get flight => _flight;
  List<Passenger> get passengers => _passengers;
  String get contactEmail => _contactEmail;
  String get contactPhone => _contactPhone;
  double get totalAmount => _flight.price * _passengers.length;

  void initialize({
    required Flight flight,
    required List<Passenger> passengers,
    required String contactEmail,
    required String contactPhone,
  }) {
    _flight = flight;
    _passengers = passengers;
    _contactEmail = contactEmail;
    _contactPhone = contactPhone;
  }

  Future<void> confirmBooking() async {
    setBusy(true);
    try {
      final booking = await _bookingService.createBooking(
        flight: _flight,
        passengers: _passengers,
        contactEmail: _contactEmail,
        contactPhone: _contactPhone,
      );
      await _navigationService.replaceWithBookingConfirmationView(
        booking: booking,
      );
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  String get formattedTotalAmount => '\$${totalAmount.toStringAsFixed(2)}';
}

import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/booking/booking_model.dart';
import 'package:stacked_services/stacked_services.dart';

class BookingConfirmationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  late Booking _booking;
  Booking get booking => _booking;

  void initialize(Booking booking) {
    _booking = booking;
  }

  void navigateToHome() {
    _navigationService.clearStackAndShow('/home');
  }

  String get formattedBookingDate {
    return '${_booking.bookingDate.day}/${_booking.bookingDate.month}/${_booking.bookingDate.year}';
  }

  String get formattedTotalAmount =>
      '\$${_booking.totalAmount.toStringAsFixed(2)}';
}

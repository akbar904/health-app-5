import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/booking/booking_model.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';
import 'package:gyde_app/models/flight/flight_model.dart';

class BookingService with ListenableServiceMixin {
  final List<Booking> _bookings = [];

  Future<Booking> createBooking({
    required Flight flight,
    required List<Passenger> passengers,
    required String contactEmail,
    required String contactPhone,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      flight: flight,
      passengers: passengers,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
      status: BookingStatus.confirmed,
      bookingDate: DateTime.now(),
      totalAmount: flight.price * passengers.length,
    );

    _bookings.add(booking);
    return booking;
  }

  Future<Booking?> getBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _bookings.firstWhere((booking) => booking.id == bookingId);
    } catch (e) {
      return null;
    }
  }

  Future<List<Booking>> getUserBookings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _bookings.where((booking) => booking.id.contains(userId)).toList();
  }

  Future<bool> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final bookingIndex = _bookings.indexWhere((b) => b.id == bookingId);
      if (bookingIndex != -1) {
        _bookings[bookingIndex] = _bookings[bookingIndex].copyWith(
          status: BookingStatus.cancelled,
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

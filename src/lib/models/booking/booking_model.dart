import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';

class Booking {
  final String id;
  final Flight flight;
  final List<Passenger> passengers;
  final String contactEmail;
  final String contactPhone;
  final BookingStatus status;
  final DateTime bookingDate;
  final double totalAmount;

  Booking({
    required this.id,
    required this.flight,
    required this.passengers,
    required this.contactEmail,
    required this.contactPhone,
    required this.status,
    required this.bookingDate,
    required this.totalAmount,
  });

  Booking copyWith({
    String? id,
    Flight? flight,
    List<Passenger>? passengers,
    String? contactEmail,
    String? contactPhone,
    BookingStatus? status,
    DateTime? bookingDate,
    double? totalAmount,
  }) {
    return Booking(
      id: id ?? this.id,
      flight: flight ?? this.flight,
      passengers: passengers ?? this.passengers,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      status: status ?? this.status,
      bookingDate: bookingDate ?? this.bookingDate,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

enum BookingStatus {
  pending,
  confirmed,
  cancelled;

  String get display {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}

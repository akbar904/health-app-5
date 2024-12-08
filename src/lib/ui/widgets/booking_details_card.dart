import 'package:flutter/material.dart';
import 'package:gyde_app/models/booking/booking_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:intl/intl.dart';

class BookingDetailsCard extends StatelessWidget {
  final Booking booking;

  const BookingDetailsCard({
    required this.booking,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const Divider(height: 32),
            _buildFlightDetails(),
            const Divider(height: 32),
            _buildPassengersList(),
            const Divider(height: 32),
            _buildContactInfo(),
            const Divider(height: 32),
            _buildPriceInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Reference',
              style: TextStyle(color: kcMediumGrey),
            ),
            Text(
              booking.id,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: booking.status == BookingStatus.confirmed
                ? Colors.green
                : Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            booking.status.display,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlightDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Flight Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(booking.flight.airline),
            Text('Flight ${booking.flight.flightNumber}'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${booking.flight.departureCity} - ${booking.flight.arrivalCity}',
            ),
            Text(
              DateFormat('dd MMM yyyy').format(booking.flight.departureTime),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPassengersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Passengers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...booking.passengers.map((passenger) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${passenger.firstName} ${passenger.lastName}'),
                  Text(passenger.type.display),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text('Email: ${booking.contactEmail}'),
        Text('Phone: ${booking.contactPhone}'),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Amount',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '\$${booking.totalAmount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kcPrimaryColor,
          ),
        ),
      ],
    );
  }
}

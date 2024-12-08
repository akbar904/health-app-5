import 'package:flutter/material.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:intl/intl.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
  final VoidCallback onTap;

  const FlightCard({
    required this.flight,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    flight.airline,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Flight ${flight.flightNumber}',
                    style: const TextStyle(color: kcMediumGrey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeColumn(
                    DateFormat('HH:mm').format(flight.departureTime),
                    flight.departureCity,
                  ),
                  _buildFlightDuration(),
                  _buildTimeColumn(
                    DateFormat('HH:mm').format(flight.arrivalTime),
                    flight.arrivalCity,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${flight.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kcPrimaryColor,
                    ),
                  ),
                  Text(
                    '${flight.availableSeats} seats left',
                    style: TextStyle(
                      color: flight.availableSeats < 10
                          ? Colors.red
                          : kcMediumGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String time, String city) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          city,
          style: const TextStyle(color: kcMediumGrey),
        ),
      ],
    );
  }

  Widget _buildFlightDuration() {
    return Column(
      children: [
        const Icon(Icons.flight, color: kcMediumGrey),
        Text(
          '${flight.duration.inHours}h ${flight.duration.inMinutes % 60}m',
          style: const TextStyle(color: kcMediumGrey, fontSize: 12),
        ),
      ],
    );
  }
}

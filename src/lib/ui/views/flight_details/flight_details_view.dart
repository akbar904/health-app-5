import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/flight_details/flight_details_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class FlightDetailsView extends StackedView<FlightDetailsViewModel> {
  final String flightId;

  const FlightDetailsView({
    required this.flightId,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FlightDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFlightHeader(viewModel),
            const SizedBox(height: 24),
            _buildFlightInfo(viewModel),
            const SizedBox(height: 24),
            _buildPriceSection(viewModel),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: viewModel.navigateToPassengerInfo,
                child: const Text(
                  'Select Flight',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightHeader(FlightDetailsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              viewModel.flight.airline,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Flight ${viewModel.flight.flightNumber}',
              style: const TextStyle(
                fontSize: 16,
                color: kcMediumGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightInfo(FlightDetailsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFlightRoute(viewModel),
            const Divider(height: 32),
            _buildFlightDetails(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightRoute(FlightDetailsViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCityTime(
          viewModel.flight.departureCity,
          DateFormat('HH:mm').format(viewModel.flight.departureTime),
          DateFormat('MMM dd, yyyy').format(viewModel.flight.departureTime),
        ),
        Column(
          children: [
            const Icon(Icons.flight, color: kcMediumGrey),
            Text(
              viewModel.formattedDuration,
              style: const TextStyle(color: kcMediumGrey),
            ),
          ],
        ),
        _buildCityTime(
          viewModel.flight.arrivalCity,
          DateFormat('HH:mm').format(viewModel.flight.arrivalTime),
          DateFormat('MMM dd, yyyy').format(viewModel.flight.arrivalTime),
        ),
      ],
    );
  }

  Widget _buildCityTime(String city, String time, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(time),
        Text(
          date,
          style: const TextStyle(color: kcMediumGrey),
        ),
      ],
    );
  }

  Widget _buildFlightDetails(FlightDetailsViewModel viewModel) {
    return Column(
      children: [
        _buildDetailRow('Aircraft', viewModel.flight.aircraft),
        const SizedBox(height: 8),
        _buildDetailRow('Available Seats', viewModel.availabilityText),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: kcMediumGrey),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPriceSection(FlightDetailsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Price per person',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              viewModel.formattedPrice,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kcPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  FlightDetailsViewModel viewModelBuilder(BuildContext context) =>
      FlightDetailsViewModel();

  @override
  void onViewModelReady(FlightDetailsViewModel viewModel) =>
      viewModel.initialize(flightId);
}

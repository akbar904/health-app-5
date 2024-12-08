import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';
import 'package:gyde_app/ui/views/booking_summary/booking_summary_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BookingSummaryView extends StackedView<BookingSummaryViewModel> {
  final Flight flight;
  final List<Passenger> passengers;
  final String contactEmail;
  final String contactPhone;

  const BookingSummaryView({
    required this.flight,
    required this.passengers,
    required this.contactEmail,
    required this.contactPhone,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BookingSummaryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFlightSummary(viewModel),
                  const SizedBox(height: 24),
                  _buildPassengersSummary(viewModel),
                  const SizedBox(height: 24),
                  _buildContactSummary(viewModel),
                  const SizedBox(height: 24),
                  _buildPriceSummary(viewModel),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: viewModel.confirmBooking,
                      child: const Text(
                        'Confirm Booking',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildFlightSummary(BookingSummaryViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flight Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Airline: ${viewModel.flight.airline}'),
            Text('Flight: ${viewModel.flight.flightNumber}'),
            Text(
              'From: ${viewModel.flight.departureCity} To: ${viewModel.flight.arrivalCity}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengersSummary(BookingSummaryViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Passengers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...viewModel.passengers.map(
              (passenger) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${passenger.firstName} ${passenger.lastName} - ${passenger.type.display}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSummary(BookingSummaryViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Email: ${viewModel.contactEmail}'),
            Text('Phone: ${viewModel.contactPhone}'),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSummary(BookingSummaryViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Price Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total (${viewModel.passengers.length} passengers)',
                ),
                Text(
                  viewModel.formattedTotalAmount,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kcPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  BookingSummaryViewModel viewModelBuilder(BuildContext context) =>
      BookingSummaryViewModel();

  @override
  void onViewModelReady(BookingSummaryViewModel viewModel) {
    viewModel.initialize(
      flight: flight,
      passengers: passengers,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
    );
  }
}

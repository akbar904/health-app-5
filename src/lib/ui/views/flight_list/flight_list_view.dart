import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/widgets/flight_card.dart';
import 'package:gyde_app/ui/views/flight_list/flight_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FlightListView extends StackedView<FlightListViewModel> {
  final String departureCity;
  final String arrivalCity;
  final DateTime departureDate;
  final int passengers;

  const FlightListView({
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    required this.passengers,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FlightListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flights ($departureCity to $arrivalCity)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: viewModel.showSortOptions,
          ),
        ],
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(FlightListViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.hasError) {
      return Center(child: Text(viewModel.error.toString()));
    }

    if (viewModel.flights.isEmpty) {
      return const Center(
        child: Text('No flights found for your search criteria'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.flights.length,
      itemBuilder: (context, index) {
        final flight = viewModel.flights[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FlightCard(
            flight: flight,
            onTap: () => viewModel.navigateToFlightDetails(flight.id),
          ),
        );
      },
    );
  }

  @override
  FlightListViewModel viewModelBuilder(BuildContext context) =>
      FlightListViewModel();

  @override
  void onViewModelReady(FlightListViewModel viewModel) {
    viewModel.initialize(
      departureCity: departureCity,
      arrivalCity: arrivalCity,
      departureDate: departureDate,
      passengers: passengers,
    );
  }
}

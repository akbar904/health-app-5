import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/widgets/search_form.dart';
import 'package:gyde_app/ui/views/flight_search/flight_search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FlightSearchView extends StackedView<FlightSearchViewModel> {
  const FlightSearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FlightSearchViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Search'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find Your Flight',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Search for the best flight deals',
              style: TextStyle(
                color: kcMediumGrey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            SearchForm(
              availableCities: viewModel.availableCities,
              onSearch: viewModel.searchFlights,
            ),
          ],
        ),
      ),
    );
  }

  @override
  FlightSearchViewModel viewModelBuilder(BuildContext context) =>
      FlightSearchViewModel();
}

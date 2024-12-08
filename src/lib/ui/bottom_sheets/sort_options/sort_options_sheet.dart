import 'package:flutter/material.dart';
import 'package:gyde_app/services/flight_service.dart';
import 'package:gyde_app/ui/bottom_sheets/sort_options/sort_options_sheet_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SortOptionsSheet extends StackedView<SortOptionsSheetModel> {
  final Function(SheetResponse<SortOption>)? completer;
  final SheetRequest request;

  const SortOptionsSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SortOptionsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sort Flights',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildSortOption(
            'Price (Low to High)',
            SortOption.priceAscending,
            viewModel,
          ),
          _buildSortOption(
            'Price (High to Low)',
            SortOption.priceDescending,
            viewModel,
          ),
          _buildSortOption(
            'Duration (Shortest)',
            SortOption.durationAscending,
            viewModel,
          ),
          _buildSortOption(
            'Departure Time (Earliest)',
            SortOption.departureTimeAscending,
            viewModel,
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(
    String title,
    SortOption option,
    SortOptionsSheetModel viewModel,
  ) {
    return ListTile(
      title: Text(title),
      onTap: () => completer?.call(SheetResponse(data: option)),
    );
  }

  @override
  SortOptionsSheetModel viewModelBuilder(BuildContext context) =>
      SortOptionsSheetModel();
}

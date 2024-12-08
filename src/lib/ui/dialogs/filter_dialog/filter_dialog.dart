import 'package:flutter/material.dart';
import 'package:gyde_app/ui/dialogs/filter_dialog/filter_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FilterDialog extends StackedView<FilterDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const FilterDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FilterDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Flights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Airline',
                border: OutlineInputBorder(),
              ),
              value: viewModel.selectedAirline,
              items: const [
                DropdownMenuItem(value: null, child: Text('All Airlines')),
                DropdownMenuItem(
                    value: 'Skyways Air', child: Text('Skyways Air')),
                DropdownMenuItem(
                    value: 'Global Airways', child: Text('Global Airways')),
              ],
              onChanged: viewModel.setAirline,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Maximum Price: \$${viewModel.maxPrice.toStringAsFixed(0)}'),
                Slider(
                  value: viewModel.maxPrice,
                  min: 0,
                  max: 2000,
                  divisions: 20,
                  onChanged: viewModel.setMaxPrice,
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Direct Flights Only'),
              value: viewModel.isDirectFlightsOnly,
              onChanged: (value) =>
                  viewModel.setDirectFlightsOnly(value ?? false),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: viewModel.resetFilters,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () => completer(
                    DialogResponse(
                      confirmed: true,
                      data: {
                        'airline': viewModel.selectedAirline,
                        'maxPrice': viewModel.maxPrice,
                        'directFlights': viewModel.isDirectFlightsOnly,
                      },
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  FilterDialogModel viewModelBuilder(BuildContext context) =>
      FilterDialogModel();
}

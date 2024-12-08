import 'package:flutter/material.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/widgets/passenger_form.dart';
import 'package:gyde_app/ui/views/passenger_info/passenger_info_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PassengerInfoView extends StackedView<PassengerInfoViewModel> {
  final Flight flight;

  const PassengerInfoView({
    required this.flight,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PassengerInfoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Passenger Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPassengersList(viewModel),
            const SizedBox(height: 24),
            _buildAddPassengerButton(context, viewModel),
            const SizedBox(height: 24),
            _buildContactForm(viewModel),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: viewModel.canProceed
                    ? viewModel.navigateToBookingSummary
                    : null,
                child: const Text(
                  'Continue to Summary',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengersList(PassengerInfoViewModel viewModel) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.passengers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final passenger = viewModel.passengers[index];
        return Card(
          child: ListTile(
            title: Text('${passenger.firstName} ${passenger.lastName}'),
            subtitle: Text(passenger.type.display),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => viewModel.removePassenger(index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddPassengerButton(
    BuildContext context,
    PassengerInfoViewModel viewModel,
  ) {
    return OutlinedButton(
      onPressed: () => _showAddPassengerDialog(context, viewModel),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add),
          SizedBox(width: 8),
          Text('Add Passenger'),
        ],
      ),
    );
  }

  Widget _buildContactForm(PassengerInfoViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => viewModel.setContactInfo(
            email: value,
            phone: viewModel.contactPhone,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => viewModel.setContactInfo(
            email: viewModel.contactEmail,
            phone: value,
          ),
        ),
      ],
    );
  }

  void _showAddPassengerDialog(
    BuildContext context,
    PassengerInfoViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AddPassengerDialog(
        onSave: viewModel.addPassenger,
      ),
    );
  }

  @override
  PassengerInfoViewModel viewModelBuilder(BuildContext context) =>
      PassengerInfoViewModel();

  @override
  void onViewModelReady(PassengerInfoViewModel viewModel) =>
      viewModel.initialize(flight);
}

class AddPassengerDialog extends StatefulWidget {
  final Function(Passenger) onSave;

  const AddPassengerDialog({
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  State<AddPassengerDialog> createState() => _AddPassengerDialogState();
}

class _AddPassengerDialogState extends State<AddPassengerDialog> {
  final _formKey = GlobalKey<FormState>();
  PassengerType _type = PassengerType.adult;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Passenger',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<PassengerType>(
              value: _type,
              items: PassengerType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.display),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _type = value!);
              },
            ),
            const SizedBox(height: 16),
            PassengerForm(
              passengerType: _type,
              formKey: _formKey,
              onSaved: widget.onSave,
            ),
          ],
        ),
      ),
    );
  }
}

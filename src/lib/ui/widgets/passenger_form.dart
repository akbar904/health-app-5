import 'package:flutter/material.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class PassengerForm extends StatelessWidget {
  final PassengerType passengerType;
  final void Function(Passenger) onSaved;
  final GlobalKey<FormState> formKey;

  const PassengerForm({
    required this.passengerType,
    required this.onSaved,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            passengerType.display,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextFormField(
            label: 'First Name',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter first name' : null,
          ),
          const SizedBox(height: 12),
          _buildTextFormField(
            label: 'Last Name',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter last name' : null,
          ),
          const SizedBox(height: 12),
          _buildTextFormField(
            label: 'Date of Birth',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter date of birth' : null,
          ),
          const SizedBox(height: 12),
          _buildTextFormField(
            label: 'Nationality',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter nationality' : null,
          ),
          const SizedBox(height: 12),
          _buildTextFormField(
            label: 'Passport Number',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter passport number' : null,
          ),
          const SizedBox(height: 12),
          _buildTextFormField(
            label: 'Passport Expiry Date',
            validator: (value) => value?.isEmpty ?? true
                ? 'Please enter passport expiry date'
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      validator: validator,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class SearchForm extends StatefulWidget {
  final List<String> availableCities;
  final Function(String, String, DateTime, int) onSearch;

  const SearchForm({
    required this.availableCities,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  String _departureCity = '';
  String _arrivalCity = '';
  DateTime? _departureDate;
  int _passengers = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'From',
              border: OutlineInputBorder(),
            ),
            items: widget.availableCities
                .map((city) => DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() => _departureCity = value ?? '');
            },
            validator: (value) =>
                value == null ? 'Please select departure city' : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'To',
              border: OutlineInputBorder(),
            ),
            items: widget.availableCities
                .map((city) => DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() => _arrivalCity = value ?? '');
            },
            validator: (value) =>
                value == null ? 'Please select arrival city' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Departure Date',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) {
                setState(() => _departureDate = date);
              }
            },
            validator: (value) =>
                _departureDate == null ? 'Please select departure date' : null,
            controller: TextEditingController(
              text: _departureDate != null
                  ? '${_departureDate!.day}/${_departureDate!.month}/${_departureDate!.year}'
                  : '',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Passengers',
              border: OutlineInputBorder(),
            ),
            value: _passengers,
            items: List.generate(
              9,
              (index) => DropdownMenuItem(
                value: index + 1,
                child: Text(
                    '${index + 1} ${index == 0 ? 'passenger' : 'passengers'}'),
              ),
            ),
            onChanged: (value) {
              setState(() => _passengers = value ?? 1);
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onSearch(
                    _departureCity,
                    _arrivalCity,
                    _departureDate!,
                    _passengers,
                  );
                }
              },
              child: const Text(
                'Search Flights',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/flight/flight_model.dart';

class FlightService with ListenableServiceMixin {
  final List<Flight> _mockFlights = [
    Flight(
      id: '1',
      airline: 'Skyways Air',
      flightNumber: 'SK123',
      departureCity: 'New York',
      arrivalCity: 'London',
      departureTime: DateTime.now().add(const Duration(days: 1)),
      arrivalTime: DateTime.now().add(const Duration(days: 1, hours: 7)),
      price: 599.99,
      availableSeats: 45,
      aircraft: 'Boeing 787',
      duration: const Duration(hours: 7),
    ),
    Flight(
      id: '2',
      airline: 'Global Airways',
      flightNumber: 'GA456',
      departureCity: 'London',
      arrivalCity: 'Paris',
      departureTime: DateTime.now().add(const Duration(days: 2)),
      arrivalTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
      price: 199.99,
      availableSeats: 30,
      aircraft: 'Airbus A320',
      duration: const Duration(hours: 2),
    ),
  ];

  List<Flight> searchFlights({
    required String departureCity,
    required String arrivalCity,
    required DateTime departureDate,
    int? passengers,
  }) {
    return _mockFlights.where((flight) {
      return flight.departureCity.toLowerCase() ==
              departureCity.toLowerCase() &&
          flight.arrivalCity.toLowerCase() == arrivalCity.toLowerCase() &&
          flight.departureTime.year == departureDate.year &&
          flight.departureTime.month == departureDate.month &&
          flight.departureTime.day == departureDate.day &&
          (passengers == null || flight.availableSeats >= passengers);
    }).toList();
  }

  Flight? getFlightById(String id) {
    try {
      return _mockFlights.firstWhere((flight) => flight.id == id);
    } catch (e) {
      return null;
    }
  }

  List<String> get availableCities {
    final cities = <String>{};
    for (var flight in _mockFlights) {
      cities.add(flight.departureCity);
      cities.add(flight.arrivalCity);
    }
    return cities.toList()..sort();
  }

  List<Flight> filterAndSortFlights({
    required List<Flight> flights,
    String? airline,
    double? maxPrice,
    required SortOption sortOption,
  }) {
    var filteredFlights = flights.where((flight) {
      if (airline != null && flight.airline != airline) return false;
      if (maxPrice != null && flight.price > maxPrice) return false;
      return true;
    }).toList();

    switch (sortOption) {
      case SortOption.priceAscending:
        filteredFlights.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceDescending:
        filteredFlights.sort((a, b) => b.price.compareTo(a.price));
      case SortOption.durationAscending:
        filteredFlights.sort((a, b) => a.duration.compareTo(b.duration));
      case SortOption.departureTimeAscending:
        filteredFlights
            .sort((a, b) => a.departureTime.compareTo(b.departureTime));
    }

    return filteredFlights;
  }
}

enum SortOption {
  priceAscending,
  priceDescending,
  durationAscending,
  departureTimeAscending,
}

class Flight {
  final String id;
  final String airline;
  final String flightNumber;
  final String departureCity;
  final String arrivalCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final int availableSeats;
  final String aircraft;
  final Duration duration;

  Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.availableSeats,
    required this.aircraft,
    required this.duration,
  });

  Flight copyWith({
    String? id,
    String? airline,
    String? flightNumber,
    String? departureCity,
    String? arrivalCity,
    DateTime? departureTime,
    DateTime? arrivalTime,
    double? price,
    int? availableSeats,
    String? aircraft,
    Duration? duration,
  }) {
    return Flight(
      id: id ?? this.id,
      airline: airline ?? this.airline,
      flightNumber: flightNumber ?? this.flightNumber,
      departureCity: departureCity ?? this.departureCity,
      arrivalCity: arrivalCity ?? this.arrivalCity,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      price: price ?? this.price,
      availableSeats: availableSeats ?? this.availableSeats,
      aircraft: aircraft ?? this.aircraft,
      duration: duration ?? this.duration,
    );
  }
}

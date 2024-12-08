class Passenger {
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String nationality;
  final String passportNumber;
  final String passportExpiryDate;
  final PassengerType type;

  Passenger({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.nationality,
    required this.passportNumber,
    required this.passportExpiryDate,
    required this.type,
  });

  Passenger copyWith({
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? nationality,
    String? passportNumber,
    String? passportExpiryDate,
    PassengerType? type,
  }) {
    return Passenger(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationality: nationality ?? this.nationality,
      passportNumber: passportNumber ?? this.passportNumber,
      passportExpiryDate: passportExpiryDate ?? this.passportExpiryDate,
      type: type ?? this.type,
    );
  }
}

enum PassengerType {
  adult,
  child,
  infant;

  String get display {
    switch (this) {
      case PassengerType.adult:
        return 'Adult (12+ years)';
      case PassengerType.child:
        return 'Child (2-11 years)';
      case PassengerType.infant:
        return 'Infant (0-2 years)';
    }
  }
}

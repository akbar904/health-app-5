import 'package:stacked/stacked.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/flight/flight_model.dart';
import 'package:gyde_app/models/passenger/passenger_model.dart';
import 'package:stacked_services/stacked_services.dart';

class PassengerInfoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  late Flight _flight;
  final List<Passenger> _passengers = [];
  String _contactEmail = '';
  String _contactPhone = '';

  Flight get flight => _flight;
  List<Passenger> get passengers => _passengers;
  String get contactEmail => _contactEmail;
  String get contactPhone => _contactPhone;

  void initialize(Flight flight) {
    _flight = flight;
  }

  void addPassenger(Passenger passenger) {
    _passengers.add(passenger);
    notifyListeners();
  }

  void removePassenger(int index) {
    _passengers.removeAt(index);
    notifyListeners();
  }

  void setContactInfo({
    required String email,
    required String phone,
  }) {
    _contactEmail = email;
    _contactPhone = phone;
    notifyListeners();
  }

  bool get canProceed =>
      _passengers.isNotEmpty &&
      _contactEmail.isNotEmpty &&
      _contactPhone.isNotEmpty;

  void navigateToBookingSummary() {
    if (canProceed) {
      _navigationService.navigateToBookingSummaryView(
        flight: _flight,
        passengers: _passengers,
        contactEmail: _contactEmail,
        contactPhone: _contactPhone,
      );
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d-]{10,}$').hasMatch(phone);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:gyde_app/models/booking/booking_model.dart' as _i11;
import 'package:gyde_app/models/flight/flight_model.dart' as _i9;
import 'package:gyde_app/models/passenger/passenger_model.dart' as _i10;
import 'package:gyde_app/ui/views/booking_confirmation/booking_confirmation_view.dart'
    as _i7;
import 'package:gyde_app/ui/views/booking_summary/booking_summary_view.dart'
    as _i6;
import 'package:gyde_app/ui/views/flight_details/flight_details_view.dart'
    as _i4;
import 'package:gyde_app/ui/views/flight_list/flight_list_view.dart' as _i3;
import 'package:gyde_app/ui/views/flight_search/flight_search_view.dart' as _i2;
import 'package:gyde_app/ui/views/passenger_info/passenger_info_view.dart'
    as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i12;

class Routes {
  static const flightSearchView = '/';

  static const flightListView = '/flight-list-view';

  static const flightDetailsView = '/flight-details-view';

  static const passengerInfoView = '/passenger-info-view';

  static const bookingSummaryView = '/booking-summary-view';

  static const bookingConfirmationView = '/booking-confirmation-view';

  static const all = <String>{
    flightSearchView,
    flightListView,
    flightDetailsView,
    passengerInfoView,
    bookingSummaryView,
    bookingConfirmationView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.flightSearchView,
      page: _i2.FlightSearchView,
    ),
    _i1.RouteDef(
      Routes.flightListView,
      page: _i3.FlightListView,
    ),
    _i1.RouteDef(
      Routes.flightDetailsView,
      page: _i4.FlightDetailsView,
    ),
    _i1.RouteDef(
      Routes.passengerInfoView,
      page: _i5.PassengerInfoView,
    ),
    _i1.RouteDef(
      Routes.bookingSummaryView,
      page: _i6.BookingSummaryView,
    ),
    _i1.RouteDef(
      Routes.bookingConfirmationView,
      page: _i7.BookingConfirmationView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.FlightSearchView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.FlightSearchView(),
        settings: data,
      );
    },
    _i3.FlightListView: (data) {
      final args = data.getArgs<FlightListViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.FlightListView(
            departureCity: args.departureCity,
            arrivalCity: args.arrivalCity,
            departureDate: args.departureDate,
            passengers: args.passengers,
            key: args.key),
        settings: data,
      );
    },
    _i4.FlightDetailsView: (data) {
      final args = data.getArgs<FlightDetailsViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.FlightDetailsView(flightId: args.flightId, key: args.key),
        settings: data,
      );
    },
    _i5.PassengerInfoView: (data) {
      final args = data.getArgs<PassengerInfoViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.PassengerInfoView(flight: args.flight, key: args.key),
        settings: data,
      );
    },
    _i6.BookingSummaryView: (data) {
      final args = data.getArgs<BookingSummaryViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.BookingSummaryView(
            flight: args.flight,
            passengers: args.passengers,
            contactEmail: args.contactEmail,
            contactPhone: args.contactPhone,
            key: args.key),
        settings: data,
      );
    },
    _i7.BookingConfirmationView: (data) {
      final args =
          data.getArgs<BookingConfirmationViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.BookingConfirmationView(booking: args.booking, key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class FlightListViewArguments {
  const FlightListViewArguments({
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    required this.passengers,
    this.key,
  });

  final String departureCity;

  final String arrivalCity;

  final DateTime departureDate;

  final int passengers;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"departureCity": "$departureCity", "arrivalCity": "$arrivalCity", "departureDate": "$departureDate", "passengers": "$passengers", "key": "$key"}';
  }

  @override
  bool operator ==(covariant FlightListViewArguments other) {
    if (identical(this, other)) return true;
    return other.departureCity == departureCity &&
        other.arrivalCity == arrivalCity &&
        other.departureDate == departureDate &&
        other.passengers == passengers &&
        other.key == key;
  }

  @override
  int get hashCode {
    return departureCity.hashCode ^
        arrivalCity.hashCode ^
        departureDate.hashCode ^
        passengers.hashCode ^
        key.hashCode;
  }
}

class FlightDetailsViewArguments {
  const FlightDetailsViewArguments({
    required this.flightId,
    this.key,
  });

  final String flightId;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"flightId": "$flightId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant FlightDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.flightId == flightId && other.key == key;
  }

  @override
  int get hashCode {
    return flightId.hashCode ^ key.hashCode;
  }
}

class PassengerInfoViewArguments {
  const PassengerInfoViewArguments({
    required this.flight,
    this.key,
  });

  final _i9.Flight flight;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"flight": "$flight", "key": "$key"}';
  }

  @override
  bool operator ==(covariant PassengerInfoViewArguments other) {
    if (identical(this, other)) return true;
    return other.flight == flight && other.key == key;
  }

  @override
  int get hashCode {
    return flight.hashCode ^ key.hashCode;
  }
}

class BookingSummaryViewArguments {
  const BookingSummaryViewArguments({
    required this.flight,
    required this.passengers,
    required this.contactEmail,
    required this.contactPhone,
    this.key,
  });

  final _i9.Flight flight;

  final List<_i10.Passenger> passengers;

  final String contactEmail;

  final String contactPhone;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"flight": "$flight", "passengers": "$passengers", "contactEmail": "$contactEmail", "contactPhone": "$contactPhone", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BookingSummaryViewArguments other) {
    if (identical(this, other)) return true;
    return other.flight == flight &&
        other.passengers == passengers &&
        other.contactEmail == contactEmail &&
        other.contactPhone == contactPhone &&
        other.key == key;
  }

  @override
  int get hashCode {
    return flight.hashCode ^
        passengers.hashCode ^
        contactEmail.hashCode ^
        contactPhone.hashCode ^
        key.hashCode;
  }
}

class BookingConfirmationViewArguments {
  const BookingConfirmationViewArguments({
    required this.booking,
    this.key,
  });

  final _i11.Booking booking;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"booking": "$booking", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BookingConfirmationViewArguments other) {
    if (identical(this, other)) return true;
    return other.booking == booking && other.key == key;
  }

  @override
  int get hashCode {
    return booking.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i12.NavigationService {
  Future<dynamic> navigateToFlightSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.flightSearchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFlightListView({
    required String departureCity,
    required String arrivalCity,
    required DateTime departureDate,
    required int passengers,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.flightListView,
        arguments: FlightListViewArguments(
            departureCity: departureCity,
            arrivalCity: arrivalCity,
            departureDate: departureDate,
            passengers: passengers,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFlightDetailsView({
    required String flightId,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.flightDetailsView,
        arguments: FlightDetailsViewArguments(flightId: flightId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPassengerInfoView({
    required _i9.Flight flight,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.passengerInfoView,
        arguments: PassengerInfoViewArguments(flight: flight, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingSummaryView({
    required _i9.Flight flight,
    required List<_i10.Passenger> passengers,
    required String contactEmail,
    required String contactPhone,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookingSummaryView,
        arguments: BookingSummaryViewArguments(
            flight: flight,
            passengers: passengers,
            contactEmail: contactEmail,
            contactPhone: contactPhone,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingConfirmationView({
    required _i11.Booking booking,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookingConfirmationView,
        arguments: BookingConfirmationViewArguments(booking: booking, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFlightSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.flightSearchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFlightListView({
    required String departureCity,
    required String arrivalCity,
    required DateTime departureDate,
    required int passengers,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.flightListView,
        arguments: FlightListViewArguments(
            departureCity: departureCity,
            arrivalCity: arrivalCity,
            departureDate: departureDate,
            passengers: passengers,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFlightDetailsView({
    required String flightId,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.flightDetailsView,
        arguments: FlightDetailsViewArguments(flightId: flightId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPassengerInfoView({
    required _i9.Flight flight,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.passengerInfoView,
        arguments: PassengerInfoViewArguments(flight: flight, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingSummaryView({
    required _i9.Flight flight,
    required List<_i10.Passenger> passengers,
    required String contactEmail,
    required String contactPhone,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookingSummaryView,
        arguments: BookingSummaryViewArguments(
            flight: flight,
            passengers: passengers,
            contactEmail: contactEmail,
            contactPhone: contactPhone,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingConfirmationView({
    required _i11.Booking booking,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookingConfirmationView,
        arguments: BookingConfirmationViewArguments(booking: booking, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

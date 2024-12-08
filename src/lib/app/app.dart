import 'package:gyde_app/ui/views/flight_search/flight_search_view.dart';
import 'package:gyde_app/ui/views/flight_list/flight_list_view.dart';
import 'package:gyde_app/ui/views/flight_details/flight_details_view.dart';
import 'package:gyde_app/ui/views/passenger_info/passenger_info_view.dart';
import 'package:gyde_app/ui/views/booking_summary/booking_summary_view.dart';
import 'package:gyde_app/ui/views/booking_confirmation/booking_confirmation_view.dart';
import 'package:gyde_app/ui/bottom_sheets/sort_options/sort_options_sheet.dart';
import 'package:gyde_app/ui/dialogs/filter_dialog/filter_dialog.dart';
import 'package:gyde_app/services/flight_service.dart';
import 'package:gyde_app/services/booking_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: FlightSearchView, initial: true),
    MaterialRoute(page: FlightListView),
    MaterialRoute(page: FlightDetailsView),
    MaterialRoute(page: PassengerInfoView),
    MaterialRoute(page: BookingSummaryView),
    MaterialRoute(page: BookingConfirmationView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: FlightService),
    LazySingleton(classType: BookingService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: SortOptionsSheet),
  ],
  dialogs: [
    StackedDialog(classType: FilterDialog),
  ],
)
class App {}

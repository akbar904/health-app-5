import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/bottom_sheets/todo_filter/todo_filter_sheet.dart';
import 'package:gyde_app/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:gyde_app/ui/views/add_todo/add_todo_view.dart';
import 'package:gyde_app/ui/views/home/home_view.dart';
import 'package:gyde_app/ui/views/startup/startup_view.dart';
import 'package:gyde_app/ui/views/todo_detail/todo_detail_view.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AddTodoView),
    MaterialRoute(page: TodoDetailView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: TodoFilterSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}

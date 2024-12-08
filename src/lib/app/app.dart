import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/bottom_sheets/todo_filter/todo_filter_sheet.dart';
import 'package:gyde_app/ui/dialogs/add_todo/add_todo_dialog.dart';
import 'package:gyde_app/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:gyde_app/ui/dialogs/edit_todo/edit_todo_dialog.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:gyde_app/ui/views/home/home_view.dart';
import 'package:gyde_app/ui/views/startup/startup_view.dart';
import 'package:gyde_app/ui/views/todo/todo_view.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:gyde_app/services/storage_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: TodoView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
    LazySingleton(classType: StorageService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: TodoFilterSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddTodoDialog),
    StackedDialog(classType: EditTodoDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}

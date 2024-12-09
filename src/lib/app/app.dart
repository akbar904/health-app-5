import 'package:gyde_app/features/todo/todo_view.dart';
import 'package:gyde_app/features/todo/dialogs/todo_delete_dialog.dart';
import 'package:gyde_app/features/todo/dialogs/todo_edit_dialog.dart';
import 'package:gyde_app/features/todo/todo_repository.dart';
import 'package:gyde_app/services/storage_service.dart';
import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:gyde_app/ui/views/home/home_view.dart';
import 'package:gyde_app/ui/views/startup/startup_view.dart';
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
    LazySingleton(classType: StorageService),
    LazySingleton(classType: TodoRepository),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: TodoEditDialog),
    StackedDialog(classType: TodoDeleteDialog),
  ],
)
class App {}

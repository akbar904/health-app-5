import 'package:gyde_app/ui/bottom_sheets/add_todo/add_todo_sheet.dart';
import 'package:gyde_app/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:gyde_app/ui/views/startup/startup_view.dart';
import 'package:gyde_app/ui/views/todo/todo_view.dart';
import 'package:gyde_app/services/todo_service.dart';
import 'package:gyde_app/services/api_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: TodoView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: AddTodoSheet),
  ],
  dialogs: [
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}

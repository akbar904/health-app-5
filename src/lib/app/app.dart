import 'package:gyde_app/services/todo_service.dart';
import 'package:gyde_app/ui/bottom_sheets/add_todo/add_todo_sheet.dart';
import 'package:gyde_app/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:gyde_app/ui/dialogs/task_details/task_details_dialog.dart';
import 'package:gyde_app/ui/views/home/home_view.dart';
import 'package:gyde_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: AddTodoSheet),
  ],
  dialogs: [
    StackedDialog(classType: TaskDetailsDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}

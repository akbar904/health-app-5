import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_shared/stacked_shared.dart';
import '../services/todo_repository.dart';
import '../services/storage_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => StorageService());
  locator
      .registerLazySingleton(() => TodoRepository(locator<StorageService>()));
}

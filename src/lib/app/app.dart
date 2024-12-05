import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../features/auth/login_view.dart';
import '../features/auth/register_view.dart';
import '../features/dashboard/admin_dashboard_view.dart';
import '../features/dashboard/student_dashboard_view.dart';
import '../features/dashboard/teacher_dashboard_view.dart';
import '../features/course/course_view.dart';
import '../features/assignment/assignment_view.dart';
import '../features/profile/profile_view.dart';
import '../features/admin/user_management_view.dart';
import '../features/admin/system_config_view.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/storage_service.dart';
import '../services/analytics_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: AdminDashboardView),
    MaterialRoute(page: StudentDashboardView),
    MaterialRoute(page: TeacherDashboardView),
    MaterialRoute(page: CourseView),
    MaterialRoute(page: AssignmentView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: UserManagementView),
    MaterialRoute(page: SystemConfigView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: AnalyticsService),
  ],
)
class App {}


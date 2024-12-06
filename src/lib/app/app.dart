import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/features/home/home_view.dart';
import 'package:gyde_app/features/auth/auth_view.dart';
import 'package:gyde_app/features/dashboard/student/student_dashboard_view.dart';
import 'package:gyde_app/features/dashboard/teacher/teacher_dashboard_view.dart';
import 'package:gyde_app/features/dashboard/admin/admin_dashboard_view.dart';
import 'package:gyde_app/features/course/course_view.dart';
import 'package:gyde_app/features/assignment/assignment_view.dart';
import 'package:gyde_app/features/profile/profile_view.dart';
import 'package:gyde_app/features/admin/curriculum/curriculum_view.dart';
import 'package:gyde_app/features/admin/analytics/analytics_view.dart';
import 'package:gyde_app/features/admin/user_management/user_management_view.dart';
import 'package:gyde_app/services/auth_service.dart';
import 'package:gyde_app/services/user_service.dart';
import 'package:gyde_app/services/course_service.dart';
import 'package:gyde_app/services/assignment_service.dart';
import 'package:gyde_app/services/progress_service.dart';
import 'package:gyde_app/services/analytics_service.dart';
import 'package:gyde_app/services/communication_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: StudentDashboardView),
    MaterialRoute(page: TeacherDashboardView),
    MaterialRoute(page: AdminDashboardView),
    MaterialRoute(page: CourseView),
    MaterialRoute(page: AssignmentView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: CurriculumView),
    MaterialRoute(page: AnalyticsView),
    MaterialRoute(page: UserManagementView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: CourseService),
    LazySingleton(classType: AssignmentService),
    LazySingleton(classType: ProgressService),
    LazySingleton(classType: AnalyticsService),
    LazySingleton(classType: CommunicationService),
  ],
)
class App {}

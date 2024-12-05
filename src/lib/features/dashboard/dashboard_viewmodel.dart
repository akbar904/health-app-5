import 'package:stacked/stacked.dart';
import '../../services/analytics_service.dart';
import '../../services/user_service.dart';
import '../../app/app.locator.dart';
import '../../models/user.dart';

class DashboardViewModel extends BaseViewModel {
  final _analyticsService = locator<AnalyticsService>();
  final _userService = locator<UserService>();

  User? _currentUser;
  User? get currentUser => _currentUser;

  Map<String, dynamic> _dashboardData = {};
  Map<String, dynamic> get dashboardData => _dashboardData;

  bool get isAdmin => _currentUser?.role == 'admin';
  bool get isTeacher => _currentUser?.role == 'teacher';
  bool get isStudent => _currentUser?.role == 'student';

  Future<void> initialize() async {
    setBusy(true);
    try {
      _currentUser = await _userService.getCurrentUser();
      await _loadDashboardData();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadDashboardData() async {
    try {
      if (isAdmin) {
        _dashboardData = await _analyticsService.getAdminDashboardData();
      } else if (isTeacher) {
        _dashboardData = await _analyticsService.getTeacherDashboardData(_currentUser!.id);
      } else if (isStudent) {
        _dashboardData = await _analyticsService.getStudentDashboardData(_currentUser!.id);
      }
    } catch (e) {
      setError(e);
    }
  }

  Future<void> refreshDashboard() async {
    setBusy(true);
    try {
      await _loadDashboardData();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void navigateToProfile() {
    // Navigation implementation
  }

  void navigateToCourses() {
    // Navigation implementation
  }

  void navigateToAssignments() {
    // Navigation implementation
  }

  void navigateToAnalytics() {
    // Navigation implementation
  }

  void logout() {
    // Logout implementation
  }
}
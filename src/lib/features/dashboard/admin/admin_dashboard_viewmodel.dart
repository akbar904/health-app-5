import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/dashboard/admin/admin_dashboard_repository.dart';
import 'package:gyde_app/app/app.locator.dart';

class AdminDashboardViewModel extends BaseViewModel {
  final _repository = locator<AdminDashboardRepository>();

  int _totalStudents = 0;
  int _totalTeachers = 0;
  int _activeCourses = 0;
  List<RecentActivity> _recentActivities = [];

  int get totalStudents => _totalStudents;
  int get totalTeachers => _totalTeachers;
  int get activeCourses => _activeCourses;
  List<RecentActivity> get recentActivities => _recentActivities;

  Future<void> initialize() async {
    setBusy(true);
    try {
      await Future.wait([
        _loadUserMetrics(),
        _loadRecentActivities(),
      ]);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadUserMetrics() async {
    final metrics = await _repository.getUserMetrics();
    _totalStudents = metrics.totalStudents;
    _totalTeachers = metrics.totalTeachers;
    _activeCourses = metrics.activeCourses;
    notifyListeners();
  }

  Future<void> _loadRecentActivities() async {
    _recentActivities = await _repository.getRecentActivities();
    notifyListeners();
  }

  void navigateToUserManagement() {
    // Navigation implementation using NavigationService
  }

  void navigateToAnalytics() {
    // Navigation implementation using NavigationService
  }

  void navigateToSettings() {
    // Navigation implementation using NavigationService
  }

  Future<void> refreshDashboard() async {
    await initialize();
  }

  String getSystemStatus() {
    return 'System is running normally';
  }

  double getSystemLoad() {
    return 0.45; // Mock system load percentage
  }

  int getPendingApprovals() {
    return 5; // Mock number of pending approvals
  }
}

class RecentActivity {
  final String title;
  final String description;
  final String timeAgo;

  RecentActivity({
    required this.title,
    required this.description,
    required this.timeAgo,
  });
}

import 'package:stacked/stacked.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../services/analytics_service.dart';
import 'dashboard_repository.dart';

class DashboardViewModel extends BaseViewModel {
  final DashboardRepository _repository;
  final UserService _userService;
  final AnalyticsService _analyticsService;

  DashboardViewModel({
    required DashboardRepository repository,
    required UserService userService,
    required AnalyticsService analyticsService,
  })  : _repository = repository,
        _userService = userService,
        _analyticsService = analyticsService;

  User? _currentUser;
  User? get currentUser => _currentUser;
  
  Map<String, dynamic> _dashboardData = {};
  Map<String, dynamic> get dashboardData => _dashboardData;

  bool get isTeacher => _currentUser?.role == UserRole.teacher;
  bool get isStudent => _currentUser?.role == UserRole.student;
  bool get isAdmin => _currentUser?.role == UserRole.admin;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _currentUser = await _userService.getCurrentUser();
      await loadDashboardData();
      await _analyticsService.logDashboardAccess(_currentUser!.id);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadDashboardData() async {
    try {
      switch (_currentUser?.role) {
        case UserRole.student:
          _dashboardData = await _repository.getStudentDashboardData(_currentUser!.id);
          break;
        case UserRole.teacher:
          _dashboardData = await _repository.getTeacherDashboardData(_currentUser!.id);
          break;
        case UserRole.admin:
          _dashboardData = await _repository.getAdminDashboardData();
          break;
        case UserRole.parent:
          _dashboardData = await _repository.getParentDashboardData(_currentUser!.id);
          break;
        default:
          _dashboardData = {};
      }
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> refreshData() async {
    setBusy(true);
    try {
      await loadDashboardData();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateUserPreferences(Map<String, dynamic> preferences) async {
    try {
      await _userService.updateUserPreferences(_currentUser!.id, preferences);
      await loadDashboardData();
    } catch (e) {
      setError(e);
    }
  }

  Future<Map<String, dynamic>> getAnalytics(String metric, {DateTime? startDate, DateTime? endDate}) async {
    try {
      return await _analyticsService.getMetricData(
        userId: _currentUser!.id,
        metric: metric,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      setError(e);
      return {};
    }
  }

  Future<void> exportDashboardData(String format) async {
    setBusy(true);
    try {
      await _repository.exportDashboardData(
        userId: _currentUser!.id,
        format: format,
        data: _dashboardData,
      );
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
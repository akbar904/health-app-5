import 'package:stacked/stacked.dart';
import '../../services/user_service.dart';
import '../../services/analytics_service.dart';
import '../../models/user.dart';

class DashboardViewModel extends BaseViewModel {
  final UserService _userService;
  final AnalyticsService _analyticsService;
  
  User? _currentUser;
  Map<String, dynamic> _userStats = {};
  List<dynamic> _recentActivities = [];

  DashboardViewModel(this._userService, this._analyticsService);

  User? get currentUser => _currentUser;
  Map<String, dynamic> get userStats => _userStats;
  List<dynamic> get recentActivities => _recentActivities;

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
    if (_currentUser == null) return;

    switch (_currentUser!.role) {
      case UserRole.student:
        await _loadStudentDashboard();
        break;
      case UserRole.teacher:
        await _loadTeacherDashboard();
        break;
      case UserRole.admin:
        await _loadAdminDashboard();
        break;
      case UserRole.parent:
        await _loadParentDashboard();
        break;
    }
  }

  Future<void> _loadStudentDashboard() async {
    _userStats = await _analyticsService.getStudentStats(_currentUser!.id);
    _recentActivities = await _userService.getStudentActivities(_currentUser!.id);
  }

  Future<void> _loadTeacherDashboard() async {
    _userStats = await _analyticsService.getTeacherStats(_currentUser!.id);
    _recentActivities = await _userService.getTeacherActivities(_currentUser!.id);
  }

  Future<void> _loadAdminDashboard() async {
    _userStats = await _analyticsService.getSystemStats();
    _recentActivities = await _userService.getSystemActivities();
  }

  Future<void> _loadParentDashboard() async {
    _userStats = await _analyticsService.getParentStats(_currentUser!.id);
    _recentActivities = await _userService.getParentActivities(_currentUser!.id);
  }

  Future<void> refreshDashboard() async {
    await initialize();
  }

  Future<void> updateUserPreferences(Map<String, dynamic> preferences) async {
    setBusy(true);
    try {
      await _userService.updateUserPreferences(_currentUser!.id, preferences);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool hasPermission(String permission) {
    if (_currentUser == null) return false;
    return _userService.checkPermission(_currentUser!.role, permission);
  }
}
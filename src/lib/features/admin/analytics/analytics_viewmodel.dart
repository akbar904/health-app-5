import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/admin/analytics/analytics_repository.dart';
import 'package:gyde_app/app/app.locator.dart';

class AnalyticsViewModel extends BaseViewModel {
  final _repository = locator<AnalyticsRepository>();

  int _totalStudents = 0;
  int _totalTeachers = 0;
  int _activeCourses = 0;
  Map<String, double> _performanceMetrics = {};
  Map<String, double> _engagementMetrics = {};
  Map<String, int> _gradeLevelDistribution = {};

  int get totalStudents => _totalStudents;
  int get totalTeachers => _totalTeachers;
  int get activeCourses => _activeCourses;
  Map<String, double> get performanceMetrics => _performanceMetrics;
  Map<String, double> get engagementMetrics => _engagementMetrics;
  Map<String, int> get gradeLevelDistribution => _gradeLevelDistribution;

  Future<void> initialize() async {
    setBusy(true);
    try {
      await Future.wait([
        _loadUserMetrics(),
        _loadPerformanceMetrics(),
        _loadEngagementMetrics(),
        _loadGradeLevelDistribution(),
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

  Future<void> _loadPerformanceMetrics() async {
    _performanceMetrics = await _repository.getPerformanceMetrics();
    notifyListeners();
  }

  Future<void> _loadEngagementMetrics() async {
    _engagementMetrics = await _repository.getEngagementMetrics();
    notifyListeners();
  }

  Future<void> _loadGradeLevelDistribution() async {
    _gradeLevelDistribution = await _repository.getGradeLevelDistribution();
    notifyListeners();
  }

  Future<void> refreshData() async {
    await initialize();
  }

  double getAveragePerformance() {
    if (_performanceMetrics.isEmpty) return 0.0;
    final total = _performanceMetrics.values.reduce((a, b) => a + b);
    return total / _performanceMetrics.length;
  }

  double getAverageEngagement() {
    if (_engagementMetrics.isEmpty) return 0.0;
    final total = _engagementMetrics.values.reduce((a, b) => a + b);
    return total / _engagementMetrics.length;
  }

  int getTotalStudentsByGradeLevel(String gradeLevel) {
    return _gradeLevelDistribution[gradeLevel] ?? 0;
  }
}

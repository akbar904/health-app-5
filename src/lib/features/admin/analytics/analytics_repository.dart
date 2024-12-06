class AnalyticsRepository {
  // Mock data
  final Map<String, dynamic> _analyticsData = {
    'userMetrics': {
      'totalStudents': 150,
      'totalTeachers': 15,
      'activeCourses': 25,
    },
    'performanceMetrics': {
      'math': 85.5,
      'science': 78.3,
      'english': 82.1,
      'history': 76.8,
    },
    'engagementMetrics': {
      'dailyActiveUsers': 120,
      'averageSessionTime': 45.5,
      'assignmentCompletionRate': 88.2,
    },
    'gradeLevelDistribution': {
      'grade6': 25,
      'grade7': 30,
      'grade8': 28,
      'grade9': 32,
      'grade10': 35,
    },
  };

  Future<UserMetrics> getUserMetrics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final metrics = _analyticsData['userMetrics'] as Map<String, dynamic>;
    return UserMetrics(
      totalStudents: metrics['totalStudents'] as int,
      totalTeachers: metrics['totalTeachers'] as int,
      activeCourses: metrics['activeCourses'] as int,
    );
  }

  Future<Map<String, double>> getPerformanceMetrics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final metrics =
        _analyticsData['performanceMetrics'] as Map<String, dynamic>;
    return metrics
        .map((key, value) => MapEntry(key, (value as num).toDouble()));
  }

  Future<Map<String, double>> getEngagementMetrics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final metrics = _analyticsData['engagementMetrics'] as Map<String, dynamic>;
    return metrics
        .map((key, value) => MapEntry(key, (value as num).toDouble()));
  }

  Future<Map<String, int>> getGradeLevelDistribution() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final distribution =
        _analyticsData['gradeLevelDistribution'] as Map<String, dynamic>;
    return distribution.map((key, value) => MapEntry(key, value as int));
  }
}

class UserMetrics {
  final int totalStudents;
  final int totalTeachers;
  final int activeCourses;

  UserMetrics({
    required this.totalStudents,
    required this.totalTeachers,
    required this.activeCourses,
  });
}

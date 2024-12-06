class AdminDashboardRepository {
  // Mock data
  final Map<String, dynamic> _dashboardData = {
    'metrics': {
      'totalStudents': 150,
      'totalTeachers': 15,
      'activeCourses': 25,
    },
    'recentActivities': [
      {
        'title': 'New Student Registration',
        'description': 'John Doe joined Grade 8',
        'timeAgo': '2 hours ago',
      },
      {
        'title': 'Course Created',
        'description': 'Advanced Mathematics added to curriculum',
        'timeAgo': '5 hours ago',
      },
      {
        'title': 'System Update',
        'description': 'New features deployed successfully',
        'timeAgo': '1 day ago',
      },
    ],
  };

  Future<UserMetrics> getUserMetrics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final metrics = _dashboardData['metrics'] as Map<String, dynamic>;
    return UserMetrics(
      totalStudents: metrics['totalStudents'] as int,
      totalTeachers: metrics['totalTeachers'] as int,
      activeCourses: metrics['activeCourses'] as int,
    );
  }

  Future<List<RecentActivity>> getRecentActivities() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final activities = _dashboardData['recentActivities'] as List;
    return activities
        .map((activity) => RecentActivity(
              title: activity['title'] as String,
              description: activity['description'] as String,
              timeAgo: activity['timeAgo'] as String,
            ))
        .toList();
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

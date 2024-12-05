class AnalyticsService {
  Future<Map<String, dynamic>> getAdminDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalStudents': 1250,
      'totalTeachers': 75,
      'activeCourses': 120,
      'totalAssignments': 450,
      'averageGrade': 85.5,
      'attendanceRate': 92.3,
      'courseCompletionRate': 88.7,
      'monthlyActiveUsers': 1500,
      'recentActivities': [
        {'type': 'enrollment', 'count': 25, 'date': DateTime.now()},
        {'type': 'assignment_submission', 'count': 150, 'date': DateTime.now()},
        {'type': 'course_completion', 'count': 10, 'date': DateTime.now()},
      ],
    };
  }

  Future<Map<String, dynamic>> getTeacherDashboardData(String teacherId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalStudents': 120,
      'activeCourses': 5,
      'pendingAssignments': 25,
      'averageClassGrade': 82.5,
      'attendanceRate': 94.0,
      'studentProgress': [
        {'studentId': '1', 'progress': 85, 'name': 'John Doe'},
        {'studentId': '2', 'progress': 92, 'name': 'Jane Smith'},
      ],
      'upcomingDeadlines': [
        {'assignmentId': '1', 'title': 'Math Quiz', 'dueDate': DateTime.now()},
        {'assignmentId': '2', 'title': 'Science Project', 'dueDate': DateTime.now()},
      ],
    };
  }

  Future<Map<String, dynamic>> getStudentDashboardData(String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'enrolledCourses': 6,
      'completedAssignments': 45,
      'pendingAssignments': 5,
      'averageGrade': 88.5,
      'attendanceRate': 96.0,
      'courseProgress': [
        {'courseId': '1', 'progress': 75, 'name': 'Mathematics'},
        {'courseId': '2', 'progress': 85, 'name': 'Science'},
      ],
      'upcomingDeadlines': [
        {'assignmentId': '1', 'title': 'Math Quiz', 'dueDate': DateTime.now()},
        {'assignmentId': '2', 'title': 'Science Project', 'dueDate': DateTime.now()},
      ],
    };
  }

  Future<List<Map<String, dynamic>>> getPerformanceMetrics(
      String entityId, String entityType) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {'date': DateTime.now(), 'value': 85},
      {'date': DateTime.now().subtract(const Duration(days: 1)), 'value': 82},
      {'date': DateTime.now().subtract(const Duration(days: 2)), 'value': 88},
    ];
  }

  Future<Map<String, dynamic>> getAttendanceReport(
      String entityId, DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalDays': 20,
      'presentDays': 18,
      'absentDays': 2,
      'rate': 90.0,
      'details': [
        {'date': DateTime.now(), 'status': 'present'},
        {'date': DateTime.now().subtract(const Duration(days: 1)), 'status': 'absent'},
      ],
    };
  }

  Future<Map<String, dynamic>> getGradeDistribution(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'A': 25,
      'B': 35,
      'C': 20,
      'D': 15,
      'F': 5,
      'averageGrade': 82.5,
      'highestGrade': 98.0,
      'lowestGrade': 45.0,
    };
  }
}
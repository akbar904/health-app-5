class DashboardRepository {
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

  Future<Map<String, dynamic>> getTeacherDashboardData(String teacherId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalStudents': 120,
      'activeCourses': 5,
      'pendingAssignments': 25,
      'averageClassGrade': 82.5,
      'classAttendance': 94.0,
      'recentSubmissions': [
        {'studentId': '1', 'assignmentId': '1', 'status': 'submitted'},
        {'studentId': '2', 'assignmentId': '1', 'status': 'graded'},
      ],
      'upcomingClasses': [
        {'courseId': '1', 'title': 'Mathematics', 'time': '9:00 AM'},
        {'courseId': '2', 'title': 'Science', 'time': '10:30 AM'},
      ],
    };
  }

  Future<Map<String, dynamic>> getAdminDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalStudents': 1250,
      'totalTeachers': 75,
      'activeCourses': 120,
      'systemHealth': 98.5,
      'userActivity': [
        {'type': 'login', 'count': 450, 'date': DateTime.now()},
        {'type': 'assignment', 'count': 230, 'date': DateTime.now()},
      ],
      'resourceUtilization': {
        'storage': 75.5,
        'bandwidth': 62.3,
        'cpu': 45.8,
      },
    };
  }

  Future<List<Map<String, dynamic>>> getActivityLogs() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'userId': '1',
        'action': 'login',
        'timestamp': DateTime.now(),
        'details': 'User logged in from web browser'
      },
      {
        'userId': '2',
        'action': 'assignment_submission',
        'timestamp': DateTime.now(),
        'details': 'Submitted Math homework'
      },
    ];
  }

  Future<Map<String, dynamic>> getPerformanceMetrics() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'systemUptime': 99.9,
      'averageResponseTime': 0.5,
      'activeUsers': 325,
      'errorRate': 0.1,
    };
  }
}
import '../../models/course.dart';

class CourseRepository {
  // Mock data for demonstration
  final List<Course> _courses = [
    Course(
      id: '1',
      title: 'Mathematics 101',
      description: 'Basic mathematics course',
      teacherId: '1',
      students: ['2', '3', '4'],
      assignments: ['1', '2'],
      schedule: {
        'Monday': '9:00 AM',
        'Wednesday': '9:00 AM',
        'Friday': '9:00 AM',
      },
    ),
    Course(
      id: '2',
      title: 'Science Fundamentals',
      description: 'Introduction to science',
      teacherId: '2',
      students: ['2', '3', '5'],
      assignments: ['3', '4'],
      schedule: {
        'Tuesday': '10:00 AM',
        'Thursday': '10:00 AM',
      },
    ),
  ];

  Future<List<Course>> getCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return _courses;
  }

  Future<Course> getCourse(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _courses.firstWhere(
      (c) => c.id == id,
      orElse: () => throw Exception('Course not found'),
    );
  }

  Future<void> createCourse(Course course) async {
    await Future.delayed(const Duration(seconds: 1));
    _courses.add(course);
  }

  Future<void> updateCourse(Course course) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _courses.indexWhere((c) => c.id == course.id);
    if (index != -1) {
      _courses[index] = course;
    } else {
      throw Exception('Course not found');
    }
  }

  Future<void> deleteCourse(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _courses.removeWhere((c) => c.id == id);
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    final course = await getCourse(courseId);
    if (!course.students.contains(studentId)) {
      course.students.add(studentId);
      await updateCourse(course);
    }
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    final course = await getCourse(courseId);
    course.students.remove(studentId);
    await updateCourse(course);
  }

  Future<List<Course>> getTeacherCourses(String teacherId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _courses.where((c) => c.teacherId == teacherId).toList();
  }

  Future<List<Course>> getStudentCourses(String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _courses.where((c) => c.students.contains(studentId)).toList();
  }
}
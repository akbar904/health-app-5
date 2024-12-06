import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/utils/enums/grade_level_enum.dart';

class CourseService {
  // Mock data
  final List<Course> _courses = [];

  Future<List<Course>> getAllCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses;
  }

  Future<Course?> getCourseById(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _courses.firstWhere((course) => course.id == courseId);
    } catch (e) {
      return null;
    }
  }

  Future<List<Course>> getCoursesByTeacherId(String teacherId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses.where((course) => course.teacherId == teacherId).toList();
  }

  Future<List<Course>> getCoursesByStudentId(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses
        .where((course) => course.studentIds.contains(studentId))
        .toList();
  }

  Future<List<Course>> getCoursesByGradeLevel(GradeLevel gradeLevel) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses.where((course) => course.gradeLevel == gradeLevel).toList();
  }

  Future<void> createCourse(Course course) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _courses.add(course);
  }

  Future<void> updateCourse(Course course) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == course.id);
    if (index != -1) {
      _courses[index] = course;
    }
  }

  Future<void> deleteCourse(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _courses.removeWhere((course) => course.id == courseId);
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      final updatedStudentIds = List<String>.from(_courses[index].studentIds)
        ..add(studentId);
      _courses[index] = _courses[index].copyWith(studentIds: updatedStudentIds);
    }
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      final updatedStudentIds = List<String>.from(_courses[index].studentIds)
        ..remove(studentId);
      _courses[index] = _courses[index].copyWith(studentIds: updatedStudentIds);
    }
  }

  Future<void> addResource(String courseId, String resourceUrl) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      final updatedResourceUrls =
          List<String>.from(_courses[index].resourceUrls)..add(resourceUrl);
      _courses[index] =
          _courses[index].copyWith(resourceUrls: updatedResourceUrls);
    }
  }

  Future<void> removeResource(String courseId, String resourceUrl) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      final updatedResourceUrls =
          List<String>.from(_courses[index].resourceUrls)..remove(resourceUrl);
      _courses[index] =
          _courses[index].copyWith(resourceUrls: updatedResourceUrls);
    }
  }

  Future<List<Course>> searchCourses(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses
        .where((course) =>
            course.title.toLowerCase().contains(query.toLowerCase()) ||
            course.description.toLowerCase().contains(query.toLowerCase()) ||
            course.subject.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<int> getEnrollmentCount(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final course = _courses.firstWhere((c) => c.id == courseId,
        orElse: () => Course(
              id: '',
              title: '',
              description: '',
              teacherId: '',
              gradeLevel: GradeLevel.none,
              subject: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              studentIds: [],
              resourceUrls: [],
              isActive: false,
            ));
    return course.studentIds.length;
  }
}

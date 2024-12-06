import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/utils/enums/grade_level_enum.dart';

class CurriculumRepository {
  // Mock data
  final List<Course> _courses = [];

  Future<List<Course>> getAllCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses;
  }

  Future<Course?> getCourseById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _courses.firstWhere((course) => course.id == id);
    } catch (e) {
      return null;
    }
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

  Future<List<Course>> getCoursesByGradeLevel(GradeLevel gradeLevel) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses.where((course) => course.gradeLevel == gradeLevel).toList();
  }

  Future<List<Course>> searchCourses(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses
        .where((course) =>
            course.title.toLowerCase().contains(query.toLowerCase()) ||
            course.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Course>> getActiveCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses.where((course) => course.isActive).toList();
  }

  Future<void> bulkUpdateCourses(List<Course> courses) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (var course in courses) {
      final index = _courses.indexWhere((c) => c.id == course.id);
      if (index != -1) {
        _courses[index] = course;
      }
    }
  }
}

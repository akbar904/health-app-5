import '../../models/course.dart';
import '../../services/course_service.dart';

class CourseRepository {
  final CourseService _courseService;

  CourseRepository(this._courseService);

  Future<List<Course>> getAllCourses() async {
    return await _courseService.getAllCourses();
  }

  Future<Course> getCourseById(String courseId) async {
    return await _courseService.getCourseById(courseId);
  }

  Future<void> createCourse(Course course) async {
    await _courseService.createCourse(course);
  }

  Future<void> updateCourse(Course course) async {
    await _courseService.updateCourse(course);
  }

  Future<void> deleteCourse(String courseId) async {
    await _courseService.deleteCourse(courseId);
  }

  Future<List<Course>> getCoursesByTeacherId(String teacherId) async {
    return await _courseService.getCoursesByTeacherId(teacherId);
  }

  Future<List<Course>> getCoursesByStudentId(String studentId) async {
    return await _courseService.getCoursesByStudentId(studentId);
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    await _courseService.enrollStudent(courseId, studentId);
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    await _courseService.unenrollStudent(courseId, studentId);
  }

  Future<List<Course>> searchCourses(String query) async {
    return await _courseService.searchCourses(query);
  }

  Future<void> addCourseResource(String courseId, Map<String, dynamic> resource) async {
    await _courseService.addCourseResource(courseId, resource);
  }

  Future<void> removeCourseResource(String courseId, String resourceId) async {
    await _courseService.removeCourseResource(courseId, resourceId);
  }

  Future<void> updateCourseProgress(String courseId, String studentId, double progress) async {
    await _courseService.updateCourseProgress(courseId, studentId, progress);
  }
}
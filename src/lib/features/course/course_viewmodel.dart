import 'package:stacked/stacked.dart';
import '../../models/course.dart';
import '../../services/course_service.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';
import 'course_repository.dart';

class CourseViewModel extends BaseViewModel {
  final CourseRepository _repository;
  final CourseService _courseService;
  final UserService _userService;

  CourseViewModel({
    required CourseRepository repository,
    required CourseService courseService,
    required UserService userService,
  })  : _repository = repository,
        _courseService = courseService,
        _userService = userService;

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool get canCreateCourse => 
    _currentUser?.role == UserRole.teacher || 
    _currentUser?.role == UserRole.admin;
  
  bool get canEditCourse => 
    _currentUser?.role == UserRole.teacher || 
    _currentUser?.role == UserRole.admin;

  String _searchQuery = '';
  Map<String, dynamic> _filters = {};

  Future<void> initialize() async {
    setBusy(true);
    try {
      _currentUser = await _userService.getCurrentUser();
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadCourses() async {
    try {
      switch (_currentUser?.role) {
        case UserRole.student:
          _courses = await _repository.getEnrolledCourses(_currentUser!.id);
          break;
        case UserRole.teacher:
          _courses = await _repository.getTeacherCourses(_currentUser!.id);
          break;
        case UserRole.admin:
          _courses = await _repository.getAllCourses();
          break;
        default:
          _courses = [];
      }
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> createCourse(Course course) async {
    setBusy(true);
    try {
      await _repository.createCourse(course);
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateCourse(Course course) async {
    setBusy(true);
    try {
      await _repository.updateCourse(course);
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteCourse(String courseId) async {
    setBusy(true);
    try {
      await _repository.deleteCourse(courseId);
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    setBusy(true);
    try {
      await _courseService.enrollStudent(courseId, studentId);
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    setBusy(true);
    try {
      await _courseService.unenrollStudent(courseId, studentId);
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilters(Map<String, dynamic> filters) {
    _filters = filters;
    notifyListeners();
  }

  List<Course> getFilteredCourses() {
    return _courses.where((course) {
      bool matchesSearch = course.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                         course.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      bool matchesFilters = true;
      _filters.forEach((key, value) {
        switch (key) {
          case 'grade':
            matchesFilters &= course.grade == value;
            break;
          case 'subject':
            matchesFilters &= course.subject == value;
            break;
          case 'status':
            matchesFilters &= course.status == value;
            break;
        }
      });
      
      return matchesSearch && matchesFilters;
    }).toList();
  }

  Future<void> navigateToCourseDetails(String courseId) async {
    // Navigation implementation
  }

  Future<void> exportCourseData(String courseId, String format) async {
    setBusy(true);
    try {
      await _courseService.exportCourseData(courseId, format);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<Map<String, dynamic>> getCourseAnalytics(String courseId) async {
    try {
      return await _courseService.getCourseAnalytics(courseId);
    } catch (e) {
      setError(e);
      return {};
    }
  }
}
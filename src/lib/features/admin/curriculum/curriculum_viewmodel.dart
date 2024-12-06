import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/features/admin/curriculum/curriculum_repository.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/utils/enums/grade_level_enum.dart';

class CurriculumViewModel extends BaseViewModel {
  final _repository = locator<CurriculumRepository>();

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  String _searchQuery = '';
  GradeLevel? _selectedGradeLevel;

  String get searchQuery => _searchQuery;
  GradeLevel? get selectedGradeLevel => _selectedGradeLevel;

  Future<void> initialize() async {
    setBusy(true);
    try {
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadCourses() async {
    _courses = await _repository.getAllCourses();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setGradeLevel(GradeLevel? gradeLevel) {
    _selectedGradeLevel = gradeLevel;
    notifyListeners();
  }

  List<Course> get filteredCourses {
    return _courses.where((course) {
      bool matchesSearch = course.title
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          course.description.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesGrade = _selectedGradeLevel == null ||
          course.gradeLevel == _selectedGradeLevel;
      return matchesSearch && matchesGrade;
    }).toList();
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

  void showAddCourseDialog() {
    // Implementation for showing add course dialog
    // This would typically use the DialogService from stacked_services
  }

  void editCourse(Course course) {
    // Implementation for showing edit course dialog
    // This would typically use the DialogService from stacked_services
  }

  List<Course> getCoursesByGradeLevel(GradeLevel gradeLevel) {
    return _courses.where((course) => course.gradeLevel == gradeLevel).toList();
  }

  bool isCourseActive(String courseId) {
    final course = _courses.firstWhere(
      (course) => course.id == courseId,
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
      ),
    );
    return course.isActive;
  }
}

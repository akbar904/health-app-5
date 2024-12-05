import 'package:stacked/stacked.dart';
import '../../models/assignment.dart';
import '../../services/assignment_service.dart';
import '../../services/user_service.dart';

class AssignmentViewModel extends BaseViewModel {
  final AssignmentService _assignmentService;
  final UserService _userService;

  List<Assignment> _assignments = [];
  List<Assignment> _filteredAssignments = [];
  String _selectedFilter = 'all';
  String _searchQuery = '';

  AssignmentViewModel(this._assignmentService, this._userService);

  List<Assignment> get assignments => _filteredAssignments;
  String get selectedFilter => _selectedFilter;

  Future<void> initialize() async {
    setBusy(true);
    try {
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadAssignments() async {
    final user = await _userService.getCurrentUser();
    if (user == null) return;

    switch (user.role) {
      case UserRole.student:
        _assignments = await _assignmentService.getAssignmentsByStudent(user.id);
        break;
      case UserRole.teacher:
        _assignments = await _assignmentService.getAssignmentsByTeacher(user.id);
        break;
      default:
        _assignments = await _assignmentService.getAllAssignments();
    }
    _applyFilters();
  }

  void searchAssignments(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredAssignments = _assignments.where((assignment) {
      final matchesSearch = assignment.title.toLowerCase().contains(_searchQuery) ||
          assignment.description.toLowerCase().contains(_searchQuery);

      final matchesFilter = _selectedFilter == 'all' ||
          assignment.status.toLowerCase() == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
    notifyListeners();
  }

  Future<void> createAssignment(Assignment assignment) async {
    setBusy(true);
    try {
      await _assignmentService.createAssignment(assignment);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateAssignment(Assignment assignment) async {
    setBusy(true);
    try {
      await _assignmentService.updateAssignment(assignment);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteAssignment(String assignmentId) async {
    setBusy(true);
    try {
      await _assignmentService.deleteAssignment(assignmentId);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> submitAssignment(
      String assignmentId, Map<String, dynamic> submission) async {
    setBusy(true);
    try {
      final user = await _userService.getCurrentUser();
      if (user == null) throw Exception('User not found');
      await _assignmentService.submitAssignment(assignmentId, user.id, submission);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> gradeAssignment(
      String assignmentId, String studentId, double grade, String feedback) async {
    setBusy(true);
    try {
      await _assignmentService.gradeAssignment(
          assignmentId, studentId, grade, feedback);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool canCreateAssignment() {
    return _userService.hasPermission('create_assignment');
  }

  bool canSubmitAssignment(Assignment assignment) {
    return _userService.hasPermission('submit_assignment');
  }

  bool canGradeAssignment(Assignment assignment) {
    return _userService.hasPermission('grade_assignment');
  }
}
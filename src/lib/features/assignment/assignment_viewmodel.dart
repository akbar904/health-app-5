import 'package:stacked/stacked.dart';
import '../../models/assignment.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';
import 'assignment_repository.dart';

class AssignmentViewModel extends BaseViewModel {
  final AssignmentRepository _repository;
  final UserService _userService;

  AssignmentViewModel({
    required AssignmentRepository repository,
    required UserService userService,
  })  : _repository = repository,
        _userService = userService;

  List<Assignment> _assignments = [];
  List<Assignment> get assignments => _assignments;

  User? _currentUser;
  bool get isTeacher => _currentUser?.role == UserRole.teacher;
  bool get isStudent => _currentUser?.role == UserRole.student;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _currentUser = await _userService.getCurrentUser();
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadAssignments() async {
    try {
      if (isTeacher) {
        _assignments = await _repository.getTeacherAssignments(_currentUser!.id);
      } else if (isStudent) {
        _assignments = await _repository.getStudentAssignments(_currentUser!.id);
      }
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> createAssignment(Assignment assignment) async {
    setBusy(true);
    try {
      await _repository.createAssignment(assignment);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> submitAssignment(String assignmentId, String submission) async {
    setBusy(true);
    try {
      await _repository.submitAssignment(assignmentId, _currentUser!.id, submission);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> gradeAssignment(String assignmentId, String studentId, double grade, String feedback) async {
    setBusy(true);
    try {
      await _repository.gradeAssignment(assignmentId, studentId, grade, feedback);
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
      await _repository.deleteAssignment(assignmentId);
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
      await _repository.updateAssignment(assignment);
      await loadAssignments();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
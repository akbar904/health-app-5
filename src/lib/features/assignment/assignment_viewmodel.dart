import 'package:stacked/stacked.dart';
import '../../models/assignment.dart';
import '../../services/assignment_service.dart';
import '../../app/app.locator.dart';

class AssignmentViewModel extends BaseViewModel {
  final _assignmentService = locator<AssignmentService>();
  
  List<Assignment> _assignments = [];
  List<Assignment> get assignments => _assignments;
  
  Assignment? _currentAssignment;
  Assignment? get currentAssignment => _currentAssignment;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _assignments = await _assignmentService.getAssignments();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> createAssignment(Assignment assignment) async {
    setBusy(true);
    try {
      await _assignmentService.createAssignment(assignment);
      _assignments = await _assignmentService.getAssignments();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> submitAssignment(String assignmentId, String submission) async {
    setBusy(true);
    try {
      await _assignmentService.submitAssignment(assignmentId, submission);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> gradeAssignment(String assignmentId, double grade, String feedback) async {
    setBusy(true);
    try {
      await _assignmentService.gradeAssignment(assignmentId, grade, feedback);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void setCurrentAssignment(Assignment assignment) {
    _currentAssignment = assignment;
    notifyListeners();
  }

  Future<void> deleteAssignment(String assignmentId) async {
    setBusy(true);
    try {
      await _assignmentService.deleteAssignment(assignmentId);
      _assignments.removeWhere((a) => a.id == assignmentId);
      notifyListeners();
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
      final index = _assignments.indexWhere((a) => a.id == assignment.id);
      if (index != -1) {
        _assignments[index] = assignment;
        notifyListeners();
      }
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
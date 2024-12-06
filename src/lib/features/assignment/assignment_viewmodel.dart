import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/assignment.dart';
import 'package:gyde_app/models/grade.dart';
import 'package:gyde_app/features/assignment/assignment_repository.dart';
import 'package:gyde_app/app/app.locator.dart';

class AssignmentViewModel extends BaseViewModel {
  final _repository = locator<AssignmentRepository>();
  final String assignmentId;

  AssignmentViewModel({required this.assignmentId});

  Assignment? _assignment;
  Grade? _grade;
  bool _isSubmitted = false;

  Assignment? get assignment => _assignment;
  Grade? get grade => _grade;
  bool get isSubmitted => _isSubmitted;

  String get formattedDueDate {
    if (_assignment == null) return '';
    final date = _assignment!.dueDate;
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<void> initialize() async {
    setBusy(true);
    try {
      await Future.wait([
        _loadAssignment(),
        _loadGrade(),
      ]);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadAssignment() async {
    _assignment = await _repository.getAssignmentById(assignmentId);
    _isSubmitted = _assignment?.isSubmitted ?? false;
    notifyListeners();
  }

  Future<void> _loadGrade() async {
    if (_assignment != null) {
      _grade = await _repository.getGrade(
        assignmentId,
        'currentStudentId', // This would come from auth service
      );
      notifyListeners();
    }
  }

  Future<void> submitAssignment({
    required String content,
    required List<String> attachments,
  }) async {
    setBusy(true);
    try {
      await _repository.submitAssignment(
        assignmentId,
        'currentStudentId', // This would come from auth service
        content,
        attachments,
      );
      _isSubmitted = true;
      await _loadAssignment();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> gradeAssignment({
    required double score,
    required String feedback,
  }) async {
    setBusy(true);
    try {
      final grade = Grade(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        assignmentId: assignmentId,
        studentId: 'currentStudentId', // This would come from auth service
        score: score,
        feedback: feedback,
        gradedAt: DateTime.now(),
        gradedBy: 'currentTeacherId', // This would come from auth service
      );
      await _repository.gradeAssignment(grade);
      await _loadGrade();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}

import 'package:gyde_app/models/progress.dart';

class ProgressService {
  // Mock data
  final List<Progress> _progress = [];

  Future<Progress?> getProgressById(String progressId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _progress.firstWhere((p) => p.id == progressId);
    } catch (e) {
      return null;
    }
  }

  Future<List<Progress>> getProgressByStudentId(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _progress.where((p) => p.studentId == studentId).toList();
  }

  Future<Progress> createProgress(Progress progress) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _progress.add(progress);
    return progress;
  }

  Future<void> updateProgress(Progress progress) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _progress.indexWhere((p) => p.id == progress.id);
    if (index != -1) {
      _progress[index] = progress;
    }
  }

  Future<void> deleteProgress(String progressId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _progress.removeWhere((p) => p.id == progressId);
  }

  Future<double> getOverallProgress(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final studentProgress = _progress.where((p) => p.studentId == studentId);
    if (studentProgress.isEmpty) return 0.0;

    final total = studentProgress.fold<double>(
      0.0,
      (sum, item) => sum + item.completionPercentage,
    );
    return total / studentProgress.length;
  }

  Future<Map<String, double>> getProgressBySubject(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, double> subjectProgress = {};
    final studentProgress = _progress.where((p) => p.studentId == studentId);

    for (var progress in studentProgress) {
      if (subjectProgress.containsKey(progress.courseId)) {
        subjectProgress[progress.courseId] =
            (subjectProgress[progress.courseId]! +
                    progress.completionPercentage) /
                2;
      } else {
        subjectProgress[progress.courseId] = progress.completionPercentage;
      }
    }

    return subjectProgress;
  }
}

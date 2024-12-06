class Progress {
  final String id;
  final String studentId;
  final String courseId;
  final double completionPercentage;
  final Map<String, bool> completedTopics;
  final DateTime lastUpdated;
  final Map<String, double> assessmentScores;
  final int totalTimeSpentMinutes;

  Progress({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.completionPercentage,
    required this.completedTopics,
    required this.lastUpdated,
    required this.assessmentScores,
    required this.totalTimeSpentMinutes,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      courseId: json['courseId'] as String,
      completionPercentage: (json['completionPercentage'] as num).toDouble(),
      completedTopics: Map<String, bool>.from(json['completedTopics'] as Map),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      assessmentScores:
          Map<String, double>.from(json['assessmentScores'] as Map),
      totalTimeSpentMinutes: json['totalTimeSpentMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'courseId': courseId,
      'completionPercentage': completionPercentage,
      'completedTopics': completedTopics,
      'lastUpdated': lastUpdated.toIso8601String(),
      'assessmentScores': assessmentScores,
      'totalTimeSpentMinutes': totalTimeSpentMinutes,
    };
  }

  Progress copyWith({
    String? id,
    String? studentId,
    String? courseId,
    double? completionPercentage,
    Map<String, bool>? completedTopics,
    DateTime? lastUpdated,
    Map<String, double>? assessmentScores,
    int? totalTimeSpentMinutes,
  }) {
    return Progress(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseId: courseId ?? this.courseId,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      completedTopics: completedTopics ?? this.completedTopics,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      assessmentScores: assessmentScores ?? this.assessmentScores,
      totalTimeSpentMinutes:
          totalTimeSpentMinutes ?? this.totalTimeSpentMinutes,
    );
  }

  double getAverageAssessmentScore() {
    if (assessmentScores.isEmpty) return 0.0;
    final total = assessmentScores.values.reduce((a, b) => a + b);
    return total / assessmentScores.length;
  }

  int getCompletedTopicsCount() {
    return completedTopics.values.where((completed) => completed).length;
  }

  String getFormattedTotalTime() {
    final hours = totalTimeSpentMinutes ~/ 60;
    final minutes = totalTimeSpentMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}

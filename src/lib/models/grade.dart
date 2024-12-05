class Grade {
  final String id;
  final String assignmentId;
  final String studentId;
  final double score;
  final String feedback;
  final DateTime gradedAt;
  final String gradedBy;
  final Map<String, dynamic>? rubricScores;
  
  Grade({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.score,
    required this.feedback,
    required this.gradedAt,
    required this.gradedBy,
    this.rubricScores,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'] as String,
      assignmentId: json['assignmentId'] as String,
      studentId: json['studentId'] as String,
      score: json['score'] as double,
      feedback: json['feedback'] as String,
      gradedAt: DateTime.parse(json['gradedAt'] as String),
      gradedBy: json['gradedBy'] as String,
      rubricScores: json['rubricScores'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignmentId': assignmentId,
      'studentId': studentId,
      'score': score,
      'feedback': feedback,
      'gradedAt': gradedAt.toIso8601String(),
      'gradedBy': gradedBy,
      if (rubricScores != null) 'rubricScores': rubricScores,
    };
  }

  Grade copyWith({
    String? id,
    String? assignmentId,
    String? studentId,
    double? score,
    String? feedback,
    DateTime? gradedAt,
    String? gradedBy,
    Map<String, dynamic>? rubricScores,
  }) {
    return Grade(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
      gradedAt: gradedAt ?? this.gradedAt,
      gradedBy: gradedBy ?? this.gradedBy,
      rubricScores: rubricScores ?? this.rubricScores,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Grade &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          assignmentId == other.assignmentId &&
          studentId == other.studentId &&
          score == other.score &&
          feedback == other.feedback &&
          gradedAt == other.gradedAt &&
          gradedBy == other.gradedBy;

  @override
  int get hashCode =>
      id.hashCode ^
      assignmentId.hashCode ^
      studentId.hashCode ^
      score.hashCode ^
      feedback.hashCode ^
      gradedAt.hashCode ^
      gradedBy.hashCode;

  @override
  String toString() {
    return 'Grade{id: $id, assignmentId: $assignmentId, studentId: $studentId, score: $score, gradedAt: $gradedAt}';
  }
}
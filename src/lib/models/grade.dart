class Grade {
  final String id;
  final String assignmentId;
  final String studentId;
  final double score;
  final String feedback;
  final DateTime gradedAt;
  final String gradedBy;

  Grade({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.score,
    required this.feedback,
    required this.gradedAt,
    required this.gradedBy,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'] as String,
      assignmentId: json['assignmentId'] as String,
      studentId: json['studentId'] as String,
      score: (json['score'] as num).toDouble(),
      feedback: json['feedback'] as String,
      gradedAt: DateTime.parse(json['gradedAt'] as String),
      gradedBy: json['gradedBy'] as String,
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
  }) {
    return Grade(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
      gradedAt: gradedAt ?? this.gradedAt,
      gradedBy: gradedBy ?? this.gradedBy,
    );
  }
}

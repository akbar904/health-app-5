class Assignment {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String courseId;
  final String status;
  final double? grade;
  final String? submission;
  final String? feedback;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.courseId,
    required this.status,
    this.grade,
    this.submission,
    this.feedback,
  });

  Assignment copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? courseId,
    String? status,
    double? grade,
    String? submission,
    String? feedback,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      courseId: courseId ?? this.courseId,
      status: status ?? this.status,
      grade: grade ?? this.grade,
      submission: submission ?? this.submission,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'courseId': courseId,
      'status': status,
      'grade': grade,
      'submission': submission,
      'feedback': feedback,
    };
  }

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      courseId: json['courseId'] as String,
      status: json['status'] as String,
      grade: json['grade'] as double?,
      submission: json['submission'] as String?,
      feedback: json['feedback'] as String?,
    );
  }

  bool isOverdue() {
    return DateTime.now().isAfter(dueDate);
  }

  bool isSubmitted() {
    return status == 'submitted' || status == 'graded';
  }

  bool isGraded() {
    return status == 'graded';
  }
}
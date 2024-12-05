class Assignment {
  final String id;
  final String title;
  final String description;
  final String courseId;
  final String courseName;
  final String teacherId;
  final DateTime dueDate;
  final int totalPoints;
  final String status;
  final double? grade;
  final String? feedback;
  final List<Map<String, dynamic>> attachments;
  final Map<String, dynamic>? submission;
  final DateTime createdAt;
  final DateTime? submittedAt;
  final DateTime? gradedAt;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.courseName,
    required this.teacherId,
    required this.dueDate,
    this.totalPoints = 100,
    required this.status,
    this.grade,
    this.feedback,
    this.attachments = const [],
    this.submission,
    required this.createdAt,
    this.submittedAt,
    this.gradedAt,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      courseId: json['courseId'],
      courseName: json['courseName'],
      teacherId: json['teacherId'],
      dueDate: DateTime.parse(json['dueDate']),
      totalPoints: json['totalPoints'] ?? 100,
      status: json['status'],
      grade: json['grade']?.toDouble(),
      feedback: json['feedback'],
      attachments: List<Map<String, dynamic>>.from(json['attachments'] ?? []),
      submission: json['submission'],
      createdAt: DateTime.parse(json['createdAt']),
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'])
          : null,
      gradedAt:
          json['gradedAt'] != null ? DateTime.parse(json['gradedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'courseId': courseId,
      'courseName': courseName,
      'teacherId': teacherId,
      'dueDate': dueDate.toIso8601String(),
      'totalPoints': totalPoints,
      'status': status,
      'grade': grade,
      'feedback': feedback,
      'attachments': attachments,
      'submission': submission,
      'createdAt': createdAt.toIso8601String(),
      'submittedAt': submittedAt?.toIso8601String(),
      'gradedAt': gradedAt?.toIso8601String(),
    };
  }

  String formatDueDate() {
    return '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}';
  }

  bool get isOverdue =>
      dueDate.isBefore(DateTime.now()) && status.toLowerCase() == 'pending';

  bool get isSubmitted => status.toLowerCase() == 'submitted';

  bool get isGraded => status.toLowerCase() == 'graded';
}
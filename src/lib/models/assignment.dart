class Assignment {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final DateTime dueDate;
  final DateTime createdAt;
  final String teacherId;
  final double totalPoints;
  final bool isSubmitted;
  final DateTime? submittedAt;
  final String? submissionContent;
  final List<String> attachments;
  final bool allowLateSubmission;
  final AssignmentType type;

  Assignment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
    required this.teacherId,
    required this.totalPoints,
    this.isSubmitted = false,
    this.submittedAt,
    this.submissionContent,
    required this.attachments,
    this.allowLateSubmission = false,
    required this.type,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      teacherId: json['teacherId'] as String,
      totalPoints: (json['totalPoints'] as num).toDouble(),
      isSubmitted: json['isSubmitted'] as bool,
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'] as String)
          : null,
      submissionContent: json['submissionContent'] as String?,
      attachments: List<String>.from(json['attachments'] as List),
      allowLateSubmission: json['allowLateSubmission'] as bool,
      type: AssignmentType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'teacherId': teacherId,
      'totalPoints': totalPoints,
      'isSubmitted': isSubmitted,
      'submittedAt': submittedAt?.toIso8601String(),
      'submissionContent': submissionContent,
      'attachments': attachments,
      'allowLateSubmission': allowLateSubmission,
      'type': type.toString(),
    };
  }

  Assignment copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    DateTime? dueDate,
    DateTime? createdAt,
    String? teacherId,
    double? totalPoints,
    bool? isSubmitted,
    DateTime? submittedAt,
    String? submissionContent,
    List<String>? attachments,
    bool? allowLateSubmission,
    AssignmentType? type,
  }) {
    return Assignment(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      teacherId: teacherId ?? this.teacherId,
      totalPoints: totalPoints ?? this.totalPoints,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      submittedAt: submittedAt ?? this.submittedAt,
      submissionContent: submissionContent ?? this.submissionContent,
      attachments: attachments ?? this.attachments,
      allowLateSubmission: allowLateSubmission ?? this.allowLateSubmission,
      type: type ?? this.type,
    );
  }
}

enum AssignmentType {
  homework,
  quiz,
  test,
  project,
  presentation,
  essay,
  labReport,
  other,
}

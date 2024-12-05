import 'dart:convert';

class Assignment {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int maxPoints;
  final String courseId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? submissions;
  final List<String>? attachments;
  final AssignmentType type;
  final bool isActive;
  final Map<String, dynamic>? gradingRubric;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.maxPoints,
    required this.courseId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.submissions,
    this.attachments,
    this.type = AssignmentType.homework,
    this.isActive = true,
    this.gradingRubric,
  });

  Assignment copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? maxPoints,
    String? courseId,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? submissions,
    List<String>? attachments,
    AssignmentType? type,
    bool? isActive,
    Map<String, dynamic>? gradingRubric,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      maxPoints: maxPoints ?? this.maxPoints,
      courseId: courseId ?? this.courseId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      submissions: submissions ?? this.submissions,
      attachments: attachments ?? this.attachments,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      gradingRubric: gradingRubric ?? this.gradingRubric,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'maxPoints': maxPoints,
      'courseId': courseId,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'submissions': submissions,
      'attachments': attachments,
      'type': type.toString(),
      'isActive': isActive,
      'gradingRubric': gradingRubric,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      maxPoints: map['maxPoints']?.toInt() ?? 0,
      courseId: map['courseId'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      submissions: Map<String, dynamic>.from(map['submissions'] ?? {}),
      attachments: List<String>.from(map['attachments'] ?? []),
      type: AssignmentType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => AssignmentType.homework,
      ),
      isActive: map['isActive'] ?? true,
      gradingRubric: Map<String, dynamic>.from(map['gradingRubric'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Assignment.fromJson(String source) =>
      Assignment.fromMap(json.decode(source));

  bool isOverdue() {
    return DateTime.now().isAfter(dueDate);
  }

  double getSubmissionRate() {
    if (submissions == null || submissions!.isEmpty) return 0.0;
    return submissions!.length / maxPoints * 100;
  }

  Map<String, dynamic>? getStudentSubmission(String studentId) {
    return submissions?[studentId];
  }

  bool hasStudentSubmitted(String studentId) {
    return submissions?.containsKey(studentId) ?? false;
  }
}

enum AssignmentType {
  homework,
  quiz,
  exam,
  project,
  presentation,
  participation,
  other
}
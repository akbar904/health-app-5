import 'package:gyde_app/utils/enums/grade_level_enum.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String teacherId;
  final GradeLevel gradeLevel;
  final String subject;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> studentIds;
  final List<String> resourceUrls;
  final bool isActive;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.gradeLevel,
    required this.subject,
    required this.startDate,
    required this.endDate,
    required this.studentIds,
    required this.resourceUrls,
    required this.isActive,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      teacherId: json['teacherId'] as String,
      gradeLevel: GradeLevel.values.firstWhere(
        (e) => e.toString() == json['gradeLevel'],
      ),
      subject: json['subject'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      studentIds: List<String>.from(json['studentIds'] as List),
      resourceUrls: List<String>.from(json['resourceUrls'] as List),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacherId': teacherId,
      'gradeLevel': gradeLevel.toString(),
      'subject': subject,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'studentIds': studentIds,
      'resourceUrls': resourceUrls,
      'isActive': isActive,
    };
  }

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? teacherId,
    GradeLevel? gradeLevel,
    String? subject,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? studentIds,
    List<String>? resourceUrls,
    bool? isActive,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      teacherId: teacherId ?? this.teacherId,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      subject: subject ?? this.subject,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      studentIds: studentIds ?? this.studentIds,
      resourceUrls: resourceUrls ?? this.resourceUrls,
      isActive: isActive ?? this.isActive,
    );
  }
}

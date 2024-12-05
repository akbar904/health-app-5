import 'package:flutter/foundation.dart';
import 'user.dart';
import 'assignment.dart';

class Course {
  final String id;
  final String name;
  final String description;
  final String subject;
  final String grade;
  final String teacherId;
  final List<String> studentIds;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final List<String> resources;
  final Map<String, dynamic> schedule;
  final List<Assignment> assignments;
  final Map<String, dynamic> syllabus;
  final int studentCount;
  final double progress;
  final bool isArchived;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.grade,
    required this.teacherId,
    required this.studentIds,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.resources,
    required this.schedule,
    required this.assignments,
    required this.syllabus,
    required this.studentCount,
    required this.progress,
    this.isArchived = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      subject: json['subject'] as String,
      grade: json['grade'] as String,
      teacherId: json['teacherId'] as String,
      studentIds: List<String>.from(json['studentIds'] as List),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: json['status'] as String,
      resources: List<String>.from(json['resources'] as List),
      schedule: json['schedule'] as Map<String, dynamic>,
      assignments: (json['assignments'] as List)
          .map((a) => Assignment.fromJson(a as Map<String, dynamic>))
          .toList(),
      syllabus: json['syllabus'] as Map<String, dynamic>,
      studentCount: json['studentCount'] as int,
      progress: json['progress'] as double,
      isArchived: json['isArchived'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subject': subject,
      'grade': grade,
      'teacherId': teacherId,
      'studentIds': studentIds,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'resources': resources,
      'schedule': schedule,
      'assignments': assignments.map((a) => a.toJson()).toList(),
      'syllabus': syllabus,
      'studentCount': studentCount,
      'progress': progress,
      'isArchived': isArchived,
    };
  }

  Course copyWith({
    String? id,
    String? name,
    String? description,
    String? subject,
    String? grade,
    String? teacherId,
    List<String>? studentIds,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    List<String>? resources,
    Map<String, dynamic>? schedule,
    List<Assignment>? assignments,
    Map<String, dynamic>? syllabus,
    int? studentCount,
    double? progress,
    bool? isArchived,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      teacherId: teacherId ?? this.teacherId,
      studentIds: studentIds ?? this.studentIds,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      resources: resources ?? this.resources,
      schedule: schedule ?? this.schedule,
      assignments: assignments ?? this.assignments,
      syllabus: syllabus ?? this.syllabus,
      studentCount: studentCount ?? this.studentCount,
      progress: progress ?? this.progress,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          subject == other.subject &&
          grade == other.grade &&
          teacherId == other.teacherId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      subject.hashCode ^
      grade.hashCode ^
      teacherId.hashCode;

  bool hasStudent(String studentId) => studentIds.contains(studentId);
  
  bool isActive() => status == 'active';
  
  bool isCompleted() => status == 'completed';
  
  bool isPending() => status == 'pending';
  
  double getStudentProgress(String studentId) {
    // Implementation for calculating individual student progress
    return 0.0;
  }

  List<Assignment> getPendingAssignments() {
    return assignments.where((a) => a.status == 'pending').toList();
  }

  List<Assignment> getCompletedAssignments() {
    return assignments.where((a) => a.status == 'completed').toList();
  }

  bool canEnroll() {
    return status == 'active' && !isArchived;
  }

  bool canSubmitAssignments() {
    return status == 'active' && !isArchived;
  }

  DateTime? getNextAssignmentDue() {
    final pendingAssignments = getPendingAssignments();
    if (pendingAssignments.isEmpty) return null;
    return pendingAssignments
        .map((a) => a.dueDate)
        .reduce((a, b) => a.isBefore(b) ? a : b);
  }
}
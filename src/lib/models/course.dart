class Course {
  final String id;
  final String title;
  final String description;
  final String teacherId;
  final List<String> students;
  final List<String> assignments;
  final Map<String, String> schedule;
  final Map<String, dynamic>? resources;
  final String? syllabus;
  final Map<String, double>? grades;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.students,
    required this.assignments,
    required this.schedule,
    this.resources,
    this.syllabus,
    this.grades,
  });

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? teacherId,
    List<String>? students,
    List<String>? assignments,
    Map<String, String>? schedule,
    Map<String, dynamic>? resources,
    String? syllabus,
    Map<String, double>? grades,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      teacherId: teacherId ?? this.teacherId,
      students: students ?? this.students,
      assignments: assignments ?? this.assignments,
      schedule: schedule ?? this.schedule,
      resources: resources ?? this.resources,
      syllabus: syllabus ?? this.syllabus,
      grades: grades ?? this.grades,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacherId': teacherId,
      'students': students,
      'assignments': assignments,
      'schedule': schedule,
      'resources': resources,
      'syllabus': syllabus,
      'grades': grades,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      teacherId: json['teacherId'] as String,
      students: List<String>.from(json['students']),
      assignments: List<String>.from(json['assignments']),
      schedule: Map<String, String>.from(json['schedule']),
      resources: json['resources'] as Map<String, dynamic>?,
      syllabus: json['syllabus'] as String?,
      grades: json['grades'] != null
          ? Map<String, double>.from(json['grades'])
          : null,
    );
  }

  double? getStudentGrade(String studentId) {
    return grades?[studentId];
  }

  bool isEnrolled(String studentId) {
    return students.contains(studentId);
  }

  bool hasAssignment(String assignmentId) {
    return assignments.contains(assignmentId);
  }

  List<String> getClassDays() {
    return schedule.keys.toList();
  }

  String? getClassTime(String day) {
    return schedule[day];
  }
}
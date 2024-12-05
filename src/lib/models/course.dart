class Course {
  final String id;
  final String name;
  final String description;
  final String teacherId;
  final int gradeLevel;
  final String? coverImageUrl;
  final List<String> enrolledStudents;
  final List<Map<String, dynamic>> resources;
  final double? progress;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.teacherId,
    required this.gradeLevel,
    this.coverImageUrl,
    this.enrolledStudents = const [],
    this.resources = const [],
    this.progress,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      teacherId: json['teacherId'],
      gradeLevel: json['gradeLevel'],
      coverImageUrl: json['coverImageUrl'],
      enrolledStudents: List<String>.from(json['enrolledStudents'] ?? []),
      resources: List<Map<String, dynamic>>.from(json['resources'] ?? []),
      progress: json['progress']?.toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'teacherId': teacherId,
      'gradeLevel': gradeLevel,
      'coverImageUrl': coverImageUrl,
      'enrolledStudents': enrolledStudents,
      'resources': resources,
      'progress': progress,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
    };
  }

  Course copyWith({
    String? id,
    String? name,
    String? description,
    String? teacherId,
    int? gradeLevel,
    String? coverImageUrl,
    List<String>? enrolledStudents,
    List<Map<String, dynamic>>? resources,
    double? progress,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      teacherId: teacherId ?? this.teacherId,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      enrolledStudents: enrolledStudents ?? this.enrolledStudents,
      resources: resources ?? this.resources,
      progress: progress ?? this.progress,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
    );
  }
}


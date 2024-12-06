import 'package:gyde_app/utils/enums/role_enum.dart';
import 'package:gyde_app/utils/enums/grade_level_enum.dart';

class User {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final GradeLevel gradeLevel;
  final String? parentId;
  final String? parentEmail;
  final DateTime? lastLogin;
  final bool isActive;
  final Map<String, dynamic>? preferences;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.gradeLevel,
    this.parentId,
    this.parentEmail,
    this.lastLogin,
    this.isActive = true,
    this.preferences,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: UserRole.values.firstWhere(
        (r) => r.toString() == json['role'],
      ),
      gradeLevel: GradeLevel.values.firstWhere(
        (g) => g.toString() == json['gradeLevel'],
      ),
      parentId: json['parentId'] as String?,
      parentEmail: json['parentEmail'] as String?,
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
      isActive: json['isActive'] as bool? ?? true,
      preferences: json['preferences'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.toString(),
      'gradeLevel': gradeLevel.toString(),
      'parentId': parentId,
      'parentEmail': parentEmail,
      'lastLogin': lastLogin?.toIso8601String(),
      'isActive': isActive,
      'preferences': preferences,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    GradeLevel? gradeLevel,
    String? parentId,
    String? parentEmail,
    DateTime? lastLogin,
    bool? isActive,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      parentId: parentId ?? this.parentId,
      parentEmail: parentEmail ?? this.parentEmail,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      preferences: preferences ?? this.preferences,
    );
  }

  bool get isStudent => role == UserRole.student;
  bool get isTeacher => role == UserRole.teacher;
  bool get isAdmin => role == UserRole.admin;
  bool get isParent => role == UserRole.parent;
}

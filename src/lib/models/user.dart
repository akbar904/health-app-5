import 'package:flutter/foundation.dart';

enum UserRole { student, teacher, admin, parent }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final bool isEmailVerified;
  final String? avatarUrl;
  final String? phone;
  final String? address;
  final String? gradeLevel;
  final DateTime joinDate;
  final List<String>? linkedAccountIds;
  final Map<String, dynamic>? preferences;
  final bool isActive;
  final String? parentId;
  final List<String>? studentIds;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isEmailVerified,
    this.avatarUrl,
    this.phone,
    this.address,
    this.gradeLevel,
    required this.joinDate,
    this.linkedAccountIds,
    this.preferences,
    this.isActive = true,
    this.parentId,
    this.studentIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.student,
      ),
      isEmailVerified: json['isEmailVerified'] as bool,
      avatarUrl: json['avatarUrl'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      gradeLevel: json['gradeLevel'] as String?,
      joinDate: DateTime.parse(json['joinDate'] as String),
      linkedAccountIds: (json['linkedAccountIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferences: json['preferences'] as Map<String, dynamic>?,
      isActive: json['isActive'] as bool? ?? true,
      parentId: json['parentId'] as String?,
      studentIds: (json['studentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'isEmailVerified': isEmailVerified,
      'avatarUrl': avatarUrl,
      'phone': phone,
      'address': address,
      'gradeLevel': gradeLevel,
      'joinDate': joinDate.toIso8601String(),
      'linkedAccountIds': linkedAccountIds,
      'preferences': preferences,
      'isActive': isActive,
      'parentId': parentId,
      'studentIds': studentIds,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    bool? isEmailVerified,
    String? avatarUrl,
    String? phone,
    String? address,
    String? gradeLevel,
    DateTime? joinDate,
    List<String>? linkedAccountIds,
    Map<String, dynamic>? preferences,
    bool? isActive,
    String? parentId,
    List<String>? studentIds,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      joinDate: joinDate ?? this.joinDate,
      linkedAccountIds: linkedAccountIds ?? this.linkedAccountIds,
      preferences: preferences ?? this.preferences,
      isActive: isActive ?? this.isActive,
      parentId: parentId ?? this.parentId,
      studentIds: studentIds ?? this.studentIds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          role == other.role &&
          isEmailVerified == other.isEmailVerified;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      role.hashCode ^
      isEmailVerified.hashCode;

  bool get isStudent => role == UserRole.student;
  bool get isTeacher => role == UserRole.teacher;
  bool get isAdmin => role == UserRole.admin;
  bool get isParent => role == UserRole.parent;

  bool hasLinkedAccounts() => linkedAccountIds?.isNotEmpty ?? false;
  bool hasStudents() => studentIds?.isNotEmpty ?? false;
  bool hasParent() => parentId != null;
}
enum UserRole { admin, teacher, student, parent }

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.teacher:
        return 'Teacher';
      case UserRole.student:
        return 'Student';
      case UserRole.parent:
        return 'Parent';
    }
  }

  bool get canManageUsers {
    return this == UserRole.admin;
  }

  bool get canManageCourses {
    return this == UserRole.admin || this == UserRole.teacher;
  }

  bool get canViewAnalytics {
    return this == UserRole.admin || this == UserRole.teacher;
  }

  bool get canSubmitAssignments {
    return this == UserRole.student;
  }

  bool get canGradeAssignments {
    return this == UserRole.teacher || this == UserRole.admin;
  }

  bool get canViewProgress {
    return this != UserRole.admin;
  }
}

import '../models/user.dart';

class Permissions {
  static bool canManageUsers(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canManageCourses(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canCreateAssignments(UserRole role) {
    return role == UserRole.teacher || role == UserRole.admin;
  }

  static bool canGradeAssignments(UserRole role) {
    return role == UserRole.teacher || role == UserRole.admin;
  }

  static bool canViewAnalytics(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canAccessSystemConfig(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canManageParentAccounts(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canViewStudentDetails(UserRole viewerRole, String viewerId, String studentId) {
    switch (viewerRole) {
      case UserRole.admin:
        return true;
      case UserRole.teacher:
        // Additional logic to check if teacher teaches this student
        return true; // Implement proper check
      case UserRole.parent:
        // Check if parent is linked to student
        return true; // Implement proper check
      default:
        return viewerId == studentId;
    }
  }

  static bool canModifyGrades(UserRole role, String courseId) {
    return role == UserRole.teacher || role == UserRole.admin;
  }

  static bool canAccessReports(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canManageResources(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canCreateAnnouncements(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canManageCalendar(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canAccessAdminDashboard(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canAccessTeacherDashboard(UserRole role) {
    return role == UserRole.teacher || role == UserRole.admin;
  }

  static bool canAccessStudentDashboard(UserRole role) {
    return role == UserRole.student || 
           role == UserRole.parent || 
           role == UserRole.teacher || 
           role == UserRole.admin;
  }

  static bool canExportData(UserRole role) {
    return role == UserRole.admin || role == UserRole.teacher;
  }

  static bool canImportData(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canManageIntegrations(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canConfigureNotifications(UserRole role) {
    return true; // All users can configure their notifications
  }

  static bool canAccessAuditLogs(UserRole role) {
    return role == UserRole.admin;
  }
}
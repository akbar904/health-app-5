class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.gydeapp.com/v1';
  static const int apiTimeout = 30000; // milliseconds
  
  // Authentication
  static const int minPasswordLength = 8;
  static const int maxLoginAttempts = 5;
  static const int lockoutDuration = 300; // seconds
  static const int tokenExpirationDays = 7;
  
  // File Upload Limits
  static const int maxFileSize = 10485760; // 10MB in bytes
  static const List<String> allowedFileTypes = [
    'pdf', 'doc', 'docx', 'ppt', 'pptx', 
    'jpg', 'jpeg', 'png', 'mp4', 'mp3'
  ];
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache Duration
  static const int cacheDuration = 3600; // seconds
  static const int profileCacheDuration = 300; // seconds
  
  // Analytics
  static const int analyticsUpdateInterval = 300; // seconds
  static const int maxDataPoints = 1000;
  
  // UI Constants
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  
  // Animation Durations
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 350;
  static const int longAnimationDuration = 500;
  
  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String serverError = 'Server error occurred. Please try again later.';
  static const String unauthorizedError = 'Unauthorized access. Please login again.';
  static const String validationError = 'Please check your input and try again.';
  
  // Success Messages
  static const String loginSuccess = 'Successfully logged in';
  static const String logoutSuccess = 'Successfully logged out';
  static const String profileUpdateSuccess = 'Profile updated successfully';
  static const String passwordResetSuccess = 'Password reset email sent successfully';
  
  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableAnalytics = true;
  static const bool enablePushNotifications = true;
  static const bool enableMultiLanguage = true;
  
  // Security
  static const List<String> requiredPermissions = [
    'camera',
    'microphone',
    'storage'
  ];
  static const int maxSessionDuration = 3600; // seconds
  static const bool enforceStrongPassword = true;
  static const bool enableTwoFactorAuth = true;
  
  // Accessibility
  static const double minFontScale = 0.8;
  static const double maxFontScale = 2.0;
  static const bool enableScreenReader = true;
  static const bool enableHighContrast = true;
  
  // Performance
  static const int maxConcurrentRequests = 5;
  static const int maxRetryAttempts = 3;
  static const int retryDelay = 1000; // milliseconds
  
  // Content
  static const List<String> supportedLanguages = [
    'en', 'es', 'fr', 'de', 'zh'
  ];
  static const String defaultLanguage = 'en';
  static const int maxContentLength = 50000;
  
  // Grade Levels
  static const List<String> gradeLevels = [
    'K', '1', '2', '3', '4', '5',
    '6', '7', '8', '9', '10', '11', '12'
  ];
  
  // Subject Areas
  static const List<String> subjectAreas = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Arts',
    'Physical Education',
    'Technology',
    'Foreign Languages'
  ];
  
  // Role-specific Settings
  static const Map<String, List<String>> rolePermissions = {
    'admin': ['all'],
    'teacher': ['create_course', 'grade_assignments', 'view_analytics'],
    'student': ['submit_assignments', 'view_grades', 'join_courses'],
    'parent': ['view_progress', 'communicate_teachers']
  };
}
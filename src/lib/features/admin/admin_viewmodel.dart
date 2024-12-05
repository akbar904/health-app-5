import 'package:stacked/stacked.dart';
import '../../services/user_service.dart';
import '../../services/analytics_service.dart';
import '../../app/app.locator.dart';
import '../../models/user.dart';

class AdminViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _analyticsService = locator<AnalyticsService>();

  List<User> _users = [];
  List<User> get users => _users;

  List<User> _filteredUsers = [];
  List<User> get filteredUsers => _filteredUsers;

  String _selectedUserRole = 'all';
  String get selectedUserRole => _selectedUserRole;

  Map<String, dynamic> _systemConfig = {};
  Map<String, dynamic> get systemConfig => _systemConfig;

  String _newUserEmail = '';
  String _newUserRole = 'student';

  String get newUserRole => _newUserRole;

  Future<void> initialize() async {
    setBusy(true);
    try {
      await _loadUsers();
      await _loadSystemConfig();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadUsers() async {
    _users = await _userService.getUsers();
    _filteredUsers = List.from(_users);
  }

  Future<void> _loadSystemConfig() async {
    _systemConfig = {
      'enablePublicRegistration': true,
      'allowParentAccounts': true,
      'enableCourseSharing': true,
      'minPasswordLength': 8,
      'requireEmailVerification': true,
      'twoFactorAuth': false,
      'emailNotifications': true,
      'pushNotifications': true,
      'assignmentReminders': true,
      'highContrastMode': false,
      'screenReaderSupport': true,
      'defaultFontSize': 1.0,
    };
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void filterByRole(String? role) {
    if (role != null) {
      _selectedUserRole = role;
      if (role == 'all') {
        _filteredUsers = List.from(_users);
      } else {
        _filteredUsers = _users.where((user) => user.role == role).toList();
      }
      notifyListeners();
    }
  }

  void setNewUserEmail(String email) {
    _newUserEmail = email;
    notifyListeners();
  }

  void setNewUserRole(String? role) {
    if (role != null) {
      _newUserRole = role;
      notifyListeners();
    }
  }

  Future<void> addUser() async {
    if (_newUserEmail.isEmpty) {
      setError('Email cannot be empty');
      return;
    }

    setBusy(true);
    try {
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: _newUserEmail,
        name: _newUserEmail.split('@')[0],
        role: _newUserRole,
        isVerified: false,
      );
      await _userService.createUser(newUser);
      await _loadUsers();
      filterByRole(_selectedUserRole);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateUser(User user) async {
    setBusy(true);
    try {
      await _userService.updateUser(user);
      await _loadUsers();
      filterByRole(_selectedUserRole);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteUser(String userId) async {
    setBusy(true);
    try {
      await _userService.deleteUser(userId);
      await _loadUsers();
      filterByRole(_selectedUserRole);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateUserRole(String userId, String newRole) async {
    setBusy(true);
    try {
      final user = _users.firstWhere((u) => u.id == userId);
      final updatedUser = user.copyWith(role: newRole);
      await updateUser(updatedUser);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateSystemConfig(String key, dynamic value) async {
    setBusy(true);
    try {
      _systemConfig[key] = value;
      // In a real implementation, save to backend
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
import 'package:stacked/stacked.dart';
import '../../../models/user.dart';
import '../../../services/user_service.dart';
import 'user_management_repository.dart';

class UserManagementViewModel extends BaseViewModel {
  final UserManagementRepository _repository;
  final UserService _userService;

  List<User> _users = [];
  List<User> _filteredUsers = [];
  Set<UserRole> _selectedRoles = {};
  String _searchQuery = '';

  UserManagementViewModel(this._repository, this._userService);

  List<User> get users => _users;
  List<User> get filteredUsers => _filteredUsers;
  Set<UserRole> get selectedRoles => _selectedRoles;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _users = await _repository.getAllUsers();
      _applyFilters();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void searchUsers(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void toggleRoleFilter(UserRole role) {
    if (_selectedRoles.contains(role)) {
      _selectedRoles.remove(role);
    } else {
      _selectedRoles.add(role);
    }
    _applyFilters();
  }

  void _applyFilters() {
    _filteredUsers = _users.where((user) {
      final matchesSearch = user.name.toLowerCase().contains(_searchQuery) ||
          user.email.toLowerCase().contains(_searchQuery);
      final matchesRole =
          _selectedRoles.isEmpty || _selectedRoles.contains(user.role);
      return matchesSearch && matchesRole;
    }).toList();
    notifyListeners();
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    setBusy(true);
    try {
      await _repository.createUser(userData);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    setBusy(true);
    try {
      await _repository.updateUser(userId, userData);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteUser(String userId) async {
    setBusy(true);
    try {
      await _repository.deleteUser(userId);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> resetUserPassword(String userId) async {
    setBusy(true);
    try {
      await _repository.resetUserPassword(userId);
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    setBusy(true);
    try {
      await _repository.updateUser(userId, {'isActive': isActive});
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool canManageUser(User user) {
    return _userService.hasPermission('manage_users');
  }
}


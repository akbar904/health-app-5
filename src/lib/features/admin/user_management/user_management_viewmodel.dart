import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/user.dart';
import 'package:gyde_app/features/admin/user_management/user_management_repository.dart';
import 'package:gyde_app/app/app.locator.dart';

class UserManagementViewModel extends BaseViewModel {
  final _repository = locator<UserManagementRepository>();

  List<User> _users = [];
  List<User> get users => _users;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  UserRole? _selectedRole;
  UserRole? get selectedRole => _selectedRole;

  Future<void> initialize() async {
    setBusy(true);
    try {
      await loadUsers();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadUsers() async {
    _users = await _repository.getAllUsers();
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    setBusy(true);
    try {
      await _repository.createUser(user);
      await loadUsers();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateUser(User user) async {
    setBusy(true);
    try {
      await _repository.updateUser(user);
      await loadUsers();
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
      await loadUsers();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedRole(UserRole? role) {
    _selectedRole = role;
    notifyListeners();
  }

  List<User> get filteredUsers {
    return _users.where((user) {
      bool matchesSearch =
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesRole = _selectedRole == null || user.role == _selectedRole;
      return matchesSearch && matchesRole;
    }).toList();
  }

  Future<void> bulkUpdateUserRoles(
      List<String> userIds, UserRole newRole) async {
    setBusy(true);
    try {
      final usersToUpdate = _users
          .where((user) => userIds.contains(user.id))
          .map((user) => user.copyWith(role: newRole))
          .toList();
      await _repository.bulkUpdateUsers(usersToUpdate);
      await loadUsers();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  List<User> getUsersByRole(UserRole role) {
    return _users.where((user) => user.role == role).toList();
  }
}

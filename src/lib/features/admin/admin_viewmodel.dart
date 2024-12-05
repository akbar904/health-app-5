import 'package:stacked/stacked.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../services/analytics_service.dart';
import '../../services/storage_service.dart';
import 'admin_repository.dart';

class AdminViewModel extends BaseViewModel {
  final AdminRepository _repository;
  final UserService _userService;
  final AnalyticsService _analyticsService;
  final StorageService _storageService;

  AdminViewModel({
    required AdminRepository repository,
    required UserService userService,
    required AnalyticsService analyticsService,
    required StorageService storageService,
  })  : _repository = repository,
        _userService = userService,
        _analyticsService = analyticsService,
        _storageService = storageService;

  // User Management
  List<User> _users = [];
  List<User> get users => _users;

  User? _selectedUser;
  User? get selectedUser => _selectedUser;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Map<String, dynamic> _filters = {};
  Map<String, dynamic> get filters => _filters;

  // System Configuration
  String _selectedConfigSection = 'general';
  String get selectedConfigSection => _selectedConfigSection;

  Map<String, dynamic> _systemSettings = {};
  Map<String, dynamic> get systemSettings => _systemSettings;

  // Analytics
  Map<String, dynamic> _analyticsData = {};
  Map<String, dynamic> get analyticsData => _analyticsData;

  Future<void> initializeUserManagement() async {
    setBusy(true);
    try {
      await loadUsers();
      await _analyticsService.logEvent('admin_user_management_access', {});
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadUsers() async {
    try {
      _users = await _userService.getUsers(
        searchQuery: _searchQuery,
        role: _filters['role'],
        isActive: _filters['isActive'],
      );
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    setBusy(true);
    try {
      await _repository.createUser(userData);
      await loadUsers();
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

  void selectUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
    loadUsers();
  }

  void setFilters(Map<String, dynamic> newFilters) {
    _filters = newFilters;
    notifyListeners();
    loadUsers();
  }

  // System Configuration Methods
  Future<void> initializeSystemConfig() async {
    setBusy(true);
    try {
      _systemSettings = await _repository.getSystemSettings();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void setConfigSection(String section) {
    _selectedConfigSection = section;
    notifyListeners();
  }

  Future<void> updateSystemSetting(String key, dynamic value) async {
    setBusy(true);
    try {
      await _repository.updateSystemSetting(key, value);
      _systemSettings[key] = value;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> runSecurityAudit() async {
    setBusy(true);
    try {
      final results = await _repository.runSecurityAudit();
      // Handle audit results
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> backupDatabase() async {
    setBusy(true);
    try {
      await _repository.backupDatabase();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> clearSystemCache() async {
    setBusy(true);
    try {
      await _storageService.clearSettings();
      await initializeSystemConfig();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> editApiConfig() async {
    setBusy(true);
    try {
      await _repository.getApiConfiguration();
      // Handle API configuration
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> configureExternalServices() async {
    setBusy(true);
    try {
      await _repository.getExternalServicesConfig();
      // Handle external services configuration
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  // Analytics Methods
  Future<void> loadAnalyticsData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    setBusy(true);
    try {
      _analyticsData = await _analyticsService.getSystemAnalytics();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  List<dynamic> get selectedUserAccessHistory {
    if (_selectedUser == null) return [];
    return _analyticsData['userAccessHistory']?[_selectedUser!.id] ?? [];
  }
}
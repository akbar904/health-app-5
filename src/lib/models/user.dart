enum UserRole { student, teacher, admin, parent }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? avatarUrl;
  final bool isActive;
  final DateTime createdAt;
  final Map<String, dynamic> preferences;
  final List<String> permissions;
  final List<String> linkedAccounts;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
    this.isActive = true,
    required this.createdAt,
    this.preferences = const {},
    this.permissions = const [],
    this.linkedAccounts = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      avatarUrl: json['avatarUrl'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      preferences: json['preferences'] ?? {},
      permissions: List<String>.from(json['permissions'] ?? []),
      linkedAccounts: List<String>.from(json['linkedAccounts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'avatarUrl': avatarUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'preferences': preferences,
      'permissions': permissions,
      'linkedAccounts': linkedAccounts,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    Map<String, dynamic>? preferences,
    List<String>? permissions,
    List<String>? linkedAccounts,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      preferences: preferences ?? this.preferences,
      permissions: permissions ?? this.permissions,
      linkedAccounts: linkedAccounts ?? this.linkedAccounts,
    );
  }

  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }

  bool isLinkedTo(String userId) {
    return linkedAccounts.contains(userId);
  }
}
class User {
  final String id;
  final String email;
  final String name;
  final String role;
  bool isVerified;
  String? photoUrl;
  List<String>? linkedAccounts;
  Map<String, dynamic>? preferences;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.isVerified = false,
    this.photoUrl,
    this.linkedAccounts,
    this.preferences,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    bool? isVerified,
    String? photoUrl,
    List<String>? linkedAccounts,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      photoUrl: photoUrl ?? this.photoUrl,
      linkedAccounts: linkedAccounts ?? this.linkedAccounts,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'isVerified': isVerified,
      'photoUrl': photoUrl,
      'linkedAccounts': linkedAccounts,
      'preferences': preferences,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      isVerified: json['isVerified'] ?? false,
      photoUrl: json['photoUrl'],
      linkedAccounts: List<String>.from(json['linkedAccounts'] ?? []),
      preferences: json['preferences'],
    );
  }

  bool get isAdmin => role == 'admin';
  bool get isTeacher => role == 'teacher';
  bool get isStudent => role == 'student';
  bool get isParent => role == 'parent';
}
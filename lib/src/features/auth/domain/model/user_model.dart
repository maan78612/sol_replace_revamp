import 'package:sol_replace_revamp/src/core/enums/user_type.dart';

class UserModel {
  final String authId;
  final DateTime createdAt;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime dob;
  final UserType role;

  UserModel({
    required this.authId,
    required this.createdAt,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.dob,
    required this.role,
  });

  UserModel.empty()
    : authId = '',
      email = '',
      name = '',
      dob = DateTime.now(),
      imageUrl = '',
      createdAt = DateTime.now(),
      role = UserType.user;

  // Factory constructor for creating UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      authId: json['authId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String,
      dob: DateTime.parse(json['dob'] as String),
      role: UserType.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserType.guest,
      ),
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'authId': authId,
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'dob': dob.toIso8601String(),
      'role': role.name,
    };
  }

  // Factory constructor for creating UserModel from Map (for database operations)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      authId: map['authId'] ?? '',
      createdAt: map['createdAt'] is String
          ? DateTime.parse(map['createdAt'])
          : map['createdAt'] as DateTime,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      dob: map['dob'] is String
          ? DateTime.parse(map['dob'])
          : map['dob'] as DateTime,
      role: _parseUserType(map['role']),
    );
  }

  // CopyWith method for creating modified copies
  UserModel copyWith({
    String? authId,
    DateTime? createdAt,
    String? name,
    String? email,
    String? imageUrl,
    DateTime? dob,
    UserType? role,
  }) {
    return UserModel(
      authId: authId ?? this.authId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      dob: dob ?? this.dob,
      role: role ?? this.role,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.authId == authId &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.dob == dob &&
        other.role == role;
  }

  @override
  int get hashCode {
    return authId.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        dob.hashCode ^
        role.hashCode;
  }

  // Private helper method for parsing UserType from String
  static UserType _parseUserType(String? roleValue) {
    if (roleValue == null || roleValue.isEmpty) return UserType.guest;

    // Handle string format with case-insensitive matching
    final normalizedRole = roleValue.toLowerCase().trim();

    switch (normalizedRole) {
      case 'guest':
        return UserType.guest;
      case 'user':
        return UserType.user;
      case 'admin':
        return UserType.admin;
      case 'company':
        return UserType.company;
      default:
        return UserType.guest; // Default fallback
    }
  }
}

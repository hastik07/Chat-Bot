class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      displayName: map['display_name'] as String?,
      avatarUrl: map['avatar_url'] as String?,
    );
  }
} 
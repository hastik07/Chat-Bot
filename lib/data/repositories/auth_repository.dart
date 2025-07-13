import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserModel?> signUp(String email, String password) async {
    final response = await _client.auth.signUp(email: email, password: password);
    final user = response.user;
    if (user != null) {
      return UserModel(
        id: user.id,
        email: user.email ?? '',
        displayName: user.userMetadata?['display_name'] as String?,
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
      );
    }
    return null;
  }

  Future<UserModel?> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);
    final user = response.user;
    if (user != null) {
      return UserModel(
        id: user.id,
        email: user.email ?? '',
        displayName: user.userMetadata?['display_name'] as String?,
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
      );
    }
    return null;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  UserModel? getCurrentUser() {
    final user = _client.auth.currentUser;
    if (user != null) {
      return UserModel(
        id: user.id,
        email: user.email ?? '',
        displayName: user.userMetadata?['display_name'] as String?,
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
      );
    }
    return null;
  }

  Future<void> updateProfile({String? displayName, String? avatarUrl}) async {
    final updates = <String, dynamic>{};
    if (displayName != null) updates['display_name'] = displayName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    await _client.auth.updateUser(UserAttributes(data: updates));
  }
} 
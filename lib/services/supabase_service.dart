
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final supabase = Supabase.instance.client;

  // Auth
  Future<AuthResponse> signUp(String email, String password) async {
    try {
      return await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      return await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // Messages
  Future<void> sendMessage(String content) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');
    await supabase.from('messages').insert({
      'user_id': user.id,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Stream<List<Map<String, dynamic>>> subscribeToMessages() {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .execute();
  }
}


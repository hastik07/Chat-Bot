import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/chat/message_model.dart';

class ChatRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final String table = 'messages';

  Future<void> sendMessage(MessageModel message) async {
    await _client.from(table).insert(message.toMap());
  }

  Future<List<MessageModel>> getMessages() async {
    final response = await _client.from(table).select().order('timestamp');
    return (response as List)
        .map((m) => MessageModel.fromMap(m as Map<String, dynamic>))
        .toList();
  }

  Stream<List<MessageModel>> subscribeToMessages() {
    return _client
        .from(table)
        .stream(primaryKey: ['id'])
        .order('timestamp')
        .map((event) => event
            .map((m) => MessageModel.fromMap(m as Map<String, dynamic>))
            .toList());
  }

  Future<void> updateMessageStatus(String messageId, int status) async {
    await _client.from(table).update({'status': status}).eq('id', messageId);
  }
} 
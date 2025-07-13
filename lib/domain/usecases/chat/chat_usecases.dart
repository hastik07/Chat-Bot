import '../../../data/repositories/chat/chat_repository.dart';
import '../../../data/models/chat/message_model.dart';

class ChatUseCases {
  final ChatRepository repository;
  ChatUseCases(this.repository);

  Future<void> sendMessage(MessageModel message) => repository.sendMessage(message);
  Future<List<MessageModel>> getMessages() => repository.getMessages();
  Stream<List<MessageModel>> subscribeToMessages() => repository.subscribeToMessages();
  Future<void> updateMessageStatus(String messageId, int status) => repository.updateMessageStatus(messageId, status);
} 
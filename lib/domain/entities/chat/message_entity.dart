enum MessageType { text, emoji, media }
enum MessageStatus { sent, delivered, read }

class MessageEntity {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;

  MessageEntity({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.status,
    required this.type,
    this.mediaUrl,
  });
} 
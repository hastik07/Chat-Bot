enum MessageType { text, emoji, media }

enum MessageStatus { sent, delivered, read }

class MessageModel {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.status,
    required this.type,
    this.mediaUrl,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      senderId: map['sender_id'] as String,
      content: map['content'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      status: MessageStatus.values[map['status'] as int],
      type: MessageType.values[map['type'] as int],
      mediaUrl: map['media_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender_id': senderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'status': status.index,
      'type': type.index,
      'media_url': mediaUrl,
    };
  }
} 
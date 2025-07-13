import 'package:flutter/material.dart';
import '../../../data/models/chat/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isFromMe;
  final double screenWidth;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isFromMe,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = screenWidth * 0.75; // Responsive max width
    final theme = Theme.of(context);
    
    return Align(
      alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02, // Responsive margin
          vertical: 4,
        ),
        padding: EdgeInsets.all(screenWidth * 0.025), // Responsive padding
        decoration: BoxDecoration(
          color: isFromMe 
            ? theme.colorScheme.primary 
            : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMessageContent(),
            const SizedBox(height: 4),
            _buildMessageStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: TextStyle(
            fontSize: screenWidth * 0.035, // Responsive font size
            color: isFromMe ? Colors.white : null,
          ),
        );
      case MessageType.emoji:
        return Text(
          message.content,
          style: TextStyle(fontSize: screenWidth * 0.05), // Larger for emojis
        );
      case MessageType.media:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.mediaUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  message.mediaUrl!,
                  width: screenWidth * 0.5, // Responsive image width
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: screenWidth * 0.5,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
            if (message.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  message.content,
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
              ),
          ],
        );
    }
  }

  Widget _buildMessageStatus() {
    if (!isFromMe) return const SizedBox.shrink();
    
    IconData statusIcon;
    Color statusColor;
    
    switch (message.status) {
      case MessageStatus.sent:
        statusIcon = Icons.check;
        statusColor = Colors.grey;
        break;
      case MessageStatus.delivered:
        statusIcon = Icons.done_all;
        statusColor = Colors.grey;
        break;
      case MessageStatus.read:
        statusIcon = Icons.done_all;
        statusColor = Colors.blue;
        break;
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          statusIcon,
          size: screenWidth * 0.025, // Responsive icon size
          color: statusColor,
        ),
        SizedBox(width: screenWidth * 0.01),
        Text(
          _formatTime(message.timestamp),
          style: TextStyle(
            fontSize: screenWidth * 0.025, // Responsive font size
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
} 
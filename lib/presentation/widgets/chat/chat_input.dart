import 'package:flutter/material.dart';
import '../../../data/models/chat/message_model.dart';

class ChatInput extends StatefulWidget {
  final Function(MessageModel) onSendMessage;
  final bool isLoading;
  final double screenWidth;

  const ChatInput({
    super.key,
    required this.onSendMessage,
    this.isLoading = false,
    required this.screenWidth,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _showEmojiPicker = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user', // TODO: Get from auth provider
      content: _controller.text.trim(),
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
      type: MessageType.text,
    );
    
    widget.onSendMessage(message);
    _controller.clear();
  }

  void _addEmoji(String emoji) {
    _controller.text += emoji;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  void _attachMedia() {
    // TODO: Implement media attachment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Media attachment coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputHeight = widget.screenWidth * 0.12; // Responsive input height
    final buttonSize = widget.screenWidth * 0.1; // Responsive button size
    
    return Container(
      padding: EdgeInsets.all(widget.screenWidth * 0.02),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (_showEmojiPicker) _buildEmojiPicker(),
          Row(
            children: [
              // Emoji button
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _showEmojiPicker = !_showEmojiPicker;
                    });
                  },
                  icon: Icon(
                    _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions,
                    size: buttonSize * 0.5,
                  ),
                ),
              ),
              // Media attachment button
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: IconButton(
                  onPressed: _attachMedia,
                  icon: Icon(
                    Icons.attach_file,
                    size: buttonSize * 0.5,
                  ),
                ),
              ),
              // Text input
              Expanded(
                child: Container(
                  height: inputHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(inputHeight / 2),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: inputHeight * 0.3,
                        vertical: inputHeight * 0.2,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              SizedBox(width: widget.screenWidth * 0.02),
              // Send button
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: FloatingActionButton(
                  onPressed: widget.isLoading ? null : _sendMessage,
                  mini: true,
                  child: widget.isLoading
                      ? SizedBox(
                          width: buttonSize * 0.4,
                          height: buttonSize * 0.4,
                          child: const CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          Icons.send,
                          size: buttonSize * 0.5,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    final emojis = ['😀', '😂', '😍', '🤔', '👍', '❤️', '🎉', '🔥', '😎', '🤗'];
    
    return Container(
      height: widget.screenWidth * 0.15,
      margin: EdgeInsets.only(bottom: widget.screenWidth * 0.02),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: emojis.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _addEmoji(emojis[index]),
            child: Container(
              width: widget.screenWidth * 0.08,
              margin: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.01),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  emojis[index],
                  style: TextStyle(fontSize: widget.screenWidth * 0.04),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 
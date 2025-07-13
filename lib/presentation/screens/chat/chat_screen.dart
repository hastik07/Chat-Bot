import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat/chat_provider.dart';
import '../../widgets/chat/message_bubble.dart';
import '../../widgets/chat/chat_input.dart';
import '../../widgets/chat/typing_indicator.dart';
import '../../../data/models/chat/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.fetchMessages();
      chatProvider.subscribeToMessages();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _onSendMessage(MessageModel message) async {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    await chatProvider.sendMessage(message);
    _scrollToBottom();
    
    // Simulate AI response
    setState(() => _isTyping = true);
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        setState(() => _isTyping = false);
        final aiMessage = MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: 'ai',
          content: _generateBotResponse(message.content),
          timestamp: DateTime.now(),
          status: MessageStatus.read,
          type: MessageType.text,
        );
        await chatProvider.sendMessage(aiMessage);
        _scrollToBottom();
      }
    });
  }

  String _generateBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('hello') || message.contains('hi')) {
      return 'Hello! How can I help you today? 😊';
    } else if (message.contains('how are you')) {
      return 'I\'m doing great, thanks for asking! How about you?';
    } else if (message.contains('bye') || message.contains('goodbye')) {
      return 'Goodbye! Have a wonderful day! 👋';
    } else if (message.contains('help')) {
      return 'I\'m here to help! What would you like to know?';
    } else if (message.contains('weather')) {
      return 'I\'d love to help with weather info, but I\'m still learning about that! 🌤️';
    } else if (message.contains('joke') || message.contains('funny')) {
      return 'Why don\'t scientists trust atoms? Because they make up everything! 😄';
    } else {
      return 'That\'s interesting! Tell me more about that. 🤔';
    }
  }

  List<MessageModel> _filterMessages(List<MessageModel> messages, String query) {
    if (query.isEmpty) return messages;
    return messages.where((message) =>
        message.content.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        
        return Scaffold(
          appBar: AppBar(
            title: _showSearch
                ? TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search messages...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => setState(() {}),
                  )
                : Text(
                    'AI Assistant',
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
            actions: [
              IconButton(
                icon: Icon(
                  _showSearch ? Icons.close : Icons.search,
                  size: screenWidth * 0.06,
                ),
                onPressed: () {
                  setState(() {
                    _showSearch = !_showSearch;
                    if (!_showSearch) {
                      _searchController.clear();
                    }
                  });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Messages list
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    final messages = _filterMessages(
                      chatProvider.messages,
                      _searchController.text,
                    );

                    if (chatProvider.isLoading && messages.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: screenWidth * 0.01,
                        ),
                      );
                    }

                    if (messages.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: screenWidth * 0.15,
                              color: Colors.grey,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'Start a conversation with AI',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      itemCount: messages.length + (_isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return TypingIndicator(
                            screenWidth: screenWidth,
                            isVisible: _isTyping,
                          );
                        }

                        final message = messages[index];
                        final isFromMe = message.senderId == 'user';

                        return MessageBubble(
                          message: message,
                          isFromMe: isFromMe,
                          screenWidth: screenWidth,
                        );
                      },
                    );
                  },
                ),
              ),
              // Chat input
              ChatInput(
                onSendMessage: _onSendMessage,
                isLoading: false,
                screenWidth: screenWidth,
              ),
            ],
          ),
        );
      },
    );
  }
} 
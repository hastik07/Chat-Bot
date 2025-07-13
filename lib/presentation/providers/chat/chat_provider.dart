import 'package:flutter/material.dart';
import '../../../domain/usecases/chat/chat_usecases.dart';
import '../../../data/models/chat/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final ChatUseCases _chatUseCases;
  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _error;
  Stream<List<MessageModel>>? _messageStream;

  ChatProvider(this._chatUseCases);

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Stream<List<MessageModel>>? get messageStream => _messageStream;

  Future<void> fetchMessages() async {
    _setLoading(true);
    try {
      _messages = await _chatUseCases.getMessages();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void subscribeToMessages() {
    _messageStream = _chatUseCases.subscribeToMessages();
    _messageStream?.listen((messages) {
      print('Received ${messages.length} messages from stream');
      _messages = messages;
      notifyListeners();
    }, onError: (error) {
      print('Error in message stream: $error');
      _error = error.toString();
      notifyListeners();
    });
  }

  Future<void> sendMessage(MessageModel message) async {
    try {
      print('Sending message: ${message.content}');
      await _chatUseCases.sendMessage(message);
      _error = null;
      print('Message sent successfully');
    } catch (e) {
      _error = e.toString();
      print('Error sending message: $e');
      notifyListeners();
    }
  }

  Future<void> updateMessageStatus(String messageId, int status) async {
    try {
      await _chatUseCases.updateMessageStatus(messageId, status);
      _error = null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
} 
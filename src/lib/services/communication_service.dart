class CommunicationService {
  // Mock data
  final List<Message> _messages = [];

  Future<void> sendMessage(Message message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _messages.add(message);
  }

  Future<List<Message>> getMessagesByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _messages
        .where((message) =>
            message.senderId == userId || message.receiverId == userId)
        .toList();
  }

  Future<void> markAsRead(String messageId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _messages.indexWhere((message) => message.id == messageId);
    if (index != -1) {
      _messages[index] = _messages[index].copyWith(isRead: true);
    }
  }

  Future<void> deleteMessage(String messageId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _messages.removeWhere((message) => message.id == messageId);
  }
}

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}

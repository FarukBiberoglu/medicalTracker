import 'package:flutter/material.dart';

import '../../../../data/models/chat_message_model.dart';
import 'message_widget.dart';

class MessageListWidget extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final String currentUserId;

  const MessageListWidget({
    required this.messages,
    required this.scrollController,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isMe = message.senderId == currentUserId;
          return MessageBubble(message: message, isMe: isMe);
        },
      ),
    );
  }
}

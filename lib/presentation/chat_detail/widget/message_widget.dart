import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  // final bool showTime;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    // required this.showTime,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child:
      Container(
        margin: EdgeInsets.only(
          left: isMe ? 60 : 8,
          right: isMe ? 8 : 60,
          bottom: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isMe ? 12 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            Transform.translate(
              offset: Offset(4, 4
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('h:mm a').format(message.timestamp.toDate()),
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (isMe) ...[
                    const SizedBox(width: 2),
                    Icon(
                      Icons.done_all,
                      size: 14,
                      color: message.status == MessageStatus.read
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'emoji_picker_widget.dart';
class ChatInputWidget extends StatelessWidget {
  final TextEditingController messageController;
  final bool isComposing;
  final Function onSendMessage;
  final Function onToggleEmoji;
  final bool showEmoji;

  const ChatInputWidget({
    required this.messageController,
    required this.isComposing,
    required this.onSendMessage,
    required this.onToggleEmoji,
    required this.showEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => onToggleEmoji(),
                icon: const Icon(Icons.emoji_emotions),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onTap: () {
                    if (showEmoji) {
                      onToggleEmoji();
                    }
                  },
                  controller: messageController,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    fillColor: Theme.of(context).cardColor,
                  ),

                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: isComposing ? () => onSendMessage() : null,
                icon: Icon(
                  Icons.send,
                  color: isComposing
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
          if (showEmoji) EmojiPickerWidget(messageController: messageController),
        ],
      ),
    );
  }
}

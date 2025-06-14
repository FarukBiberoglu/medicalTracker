import 'dart:io';

import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojiPickerWidget extends StatelessWidget {
  final TextEditingController messageController;

  const EmojiPickerWidget({required this.messageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        textEditingController: messageController,
        onEmojiSelected: (category, emoji) {
          messageController
            ..text += emoji.emoji
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: messageController.text.length),
            );
        },
        config: Config(
          height: 250,
          emojiViewConfig: EmojiViewConfig(
            columns: 7,
            emojiSizeMax: 32.0 * (Platform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            loadingIndicator: const SizedBox.shrink(),
          ),
          categoryViewConfig: const CategoryViewConfig(
            initCategory: Category.RECENT,
          ),
          bottomActionBarConfig: BottomActionBarConfig(
            enabled: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            buttonColor: Theme.of(context).primaryColor,
          ),
          skinToneConfig: const SkinToneConfig(
            enabled: true,
            dialogBackgroundColor: Colors.white,
            indicatorColor: Colors.grey,
          ),
          searchViewConfig: SearchViewConfig(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            buttonIconColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import '../../chat/cubit/chat_cubit.dart';
import '../../chat/cubit/chat_cubit_state.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String receiverName;
  final String receiverId;
  final ChatCubit chatCubit;

  const ChatAppBar({
    super.key,
    required this.receiverName,
    required this.receiverId,
    required this.chatCubit,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(receiverName[0].toUpperCase()),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(receiverName),
            ],
          ),
        ],
      ),
      actions: [
        BlocBuilder<ChatCubit, ChatState>(
          bloc: chatCubit,
          builder: (context, state) {
            if (state.isUserBlocked) {
              return TextButton.icon(
                onPressed: () => chatCubit.unBlockUser(receiverId),
                icon: const Icon(Icons.block),
                label: const Text("Unblock"),
              );
            }

            return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.block, color: Colors.red),
                            title: const Text("Block User", style: TextStyle(color: Colors.red)),
                            onTap: () async {
                              Navigator.pop(context);
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Are you sure you want to block $receiverName?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child:  Text("Block", style: TextStyle(color: AppColors.primary)),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await chatCubit.blockUser(receiverId);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

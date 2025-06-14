import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/chat_detail/widget/chat_app_bar.dart';
import 'package:untitled19/presentation/chat_detail/widget/chat_input_widget.dart';
import 'package:untitled19/presentation/chat_detail/widget/message_list_widget.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../data/service/service_locator.dart';
import '../../chat/cubit/chat_cubit.dart';
import '../../chat/cubit/chat_cubit_state.dart';

class ChatDetailView extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const ChatDetailView({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final TextEditingController messageController = TextEditingController();
  late final ChatCubit _chatCubit;
  final _scrollController = ScrollController();
  List<ChatMessage> _previousMessages = [];
  bool _isComposing = false;
  bool _showEmoji = false;

  @override
  void initState() {
    _chatCubit = getIt<ChatCubit>();
    _chatCubit.enterChat(widget.receiverId);
    messageController.addListener(_onTextChanged);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  Future<void> _handleSendMessage() async {
    final messageText = messageController.text.trim();
    messageController.clear();
    await _chatCubit.sendMessage(
      content: messageText,
      receiverId: widget.receiverId,
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _chatCubit.loadMoreMessages();
    }
  }

  void _onTextChanged() {
    final isComposing = messageController.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
      });
      if (isComposing) {
        _chatCubit.startTyping();
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _hasNewMessages(List<ChatMessage> messages) {
    if (messages.length != _previousMessages.length) {
      _scrollToBottom();
      _previousMessages = messages;
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    _chatCubit.leaveChat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        receiverName: widget.receiverName,
        receiverId: widget.receiverId,
        chatCubit: _chatCubit,
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          _hasNewMessages(state.messages);
        },
        bloc: _chatCubit,
        builder: (context, state) {
          if (state.status == ChatStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ChatStatus.error) {
            return Center(child: Text(state.error ?? "Something went wrong"));
          }
          return Column(
            children: [
              if (state.amIBlocked)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.withOpacity(0.1),
                  child: Text(
                    "You have been blocked by ${widget.receiverName}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              MessageListWidget(
                messages: state.messages,
                scrollController: _scrollController,
                currentUserId: _chatCubit.currentUserId,
              ),
              if (!state.amIBlocked && !state.isUserBlocked)
                ChatInputWidget(
                  messageController: messageController,
                  isComposing: _isComposing,
                  onSendMessage: _handleSendMessage,
                  onToggleEmoji: () {
                    setState(() {
                      _showEmoji = !_showEmoji;
                      if (_showEmoji) {
                        FocusScope.of(context).unfocus();
                      }
                    });
                  },
                  showEmoji: _showEmoji,
                ),
            ],
          );
        },
      ),
    );
  }
}
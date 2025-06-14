import 'package:flutter/material.dart';
import 'package:untitled19/data/repositories/auth_repositories.dart';
import 'package:untitled19/data/service/service_locator.dart';

import '../../../../core/constant/app_colors_constant.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/chat_list_tile.dart';
import '../../../../data/repositories/chat_repositories.dart';
import '../../../../data/repositories/contact_repositories.dart';
import '../../chat_detail/view/chat_detail_view.dart';



class DoctorChatView extends StatefulWidget {
  const DoctorChatView({super.key});

  @override
  State<DoctorChatView> createState() => _DoctorChatViewState();
}

class _DoctorChatViewState extends State<DoctorChatView> {
  late final ContactRepository _contactRepository;
  late final ChatRepository _chatRepository;
  late final String _currentUserId;

  @override
  void initState() {
    _contactRepository = getIt<ContactRepository>();
    _chatRepository = getIt<ChatRepository>();
    _currentUserId = getIt<AuthRepository>().currentUser?.uid ?? "";

    super.initState();
  }

  void _showContactsList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _contactRepository.getRegisteredContacts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final contacts = snapshot.data!;
                        if (contacts.isEmpty) {
                          return const Center(child: Text("No contacts found"));
                        }
                        return ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withValues(alpha: 0.1),
                                  child: Text(contact["name"][0].toUpperCase()),
                                ),
                                title: Text(contact["name"]),
                                onTap: () {
                                  getIt<AppRouter>().push(
                                    DoctorChatDetailView(
                                      receiverId: contact['id'],
                                      receiverName: contact['name'],
                                    ),
                                  );
                                },
                              );
                            });
                      }),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: StreamBuilder(
          stream: _chatRepository.getChatRooms(_currentUserId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text("error:${snapshot.error}"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final chats = snapshot.data!;
            if (chats.isEmpty) {
              return const Center(
                child: Text("No recent chats"),
              );
            }
            return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return ChatListTile(
                    chat: chat,
                    currentUserId: _currentUserId,
                    onTap: () {
                      final otherUserId = chat.participants
                          .firstWhere((id) => id != _currentUserId);
                      print("home screen current user id $_currentUserId");
                      final outherUserName =
                          chat.participantsName?[otherUserId] ?? "Unknown";
                      getIt<AppRouter>().push(DoctorChatDetailView(
                          receiverId: otherUserId,
                          receiverName: outherUserName));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showContactsList(context),
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}
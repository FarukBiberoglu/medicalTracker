import 'package:flutter/material.dart';
import 'package:untitled19/data/service/service_locator.dart';
import 'package:untitled19/logic/cubit/auth/auth_cubit.dart';
import 'package:untitled19/presentation/screens/auth/login_screen.dart';
import 'package:untitled19/router/app_router.dart';

import '../../data/repositories/auth_repositories.dart';
import '../../data/repositories/chat_repositories.dart';
import '../../data/repositories/contact_repositories.dart';
import '../chat/chat_vieew.dart';
import '../widgets/chat_list_tile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              children: [
                const Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
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
                                      .withOpacity(0.1),
                                  child: Text(contact["name"][0].toUpperCase()),
                                ),
                                title: Text(contact["name"]),
                                onTap: () {
                                  getIt<AppRouter>().push(
                                    ChatMessageScreen(
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
        actions: [
          InkWell(
            onTap: () async {
              await getIt<AuthCubit>().signOut();
              getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
            },
            child: const Icon(
              Icons.logout,
            ),
          )
        ],
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
                      getIt<AppRouter>().push(ChatMessageScreen(
                          receiverId: otherUserId,
                          receiverName: outherUserName));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showContactsList(context),
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}
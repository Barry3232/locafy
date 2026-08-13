import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/screens/chat.dart';
import 'package:locafy/features/services/chat_services.dart';
import 'package:locafy/models/chat.dart';
import 'package:locafy/widgets/message_section/message_tile.dart';

class MessagesScreen extends StatefulWidget {
  // final String chatId;
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ChatServices _message = ChatServices();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final chats = [
    //   {
    //     "name": "Aroma Café",
    //     "message": "Your reservation is confirmed.",
    //     "time": "2m",
    //     "unread": 2,
    //     "online": true,
    //   },
    //   {
    //     "name": "Grand Hotel",
    //     "message": "Rooms are available this weekend.",
    //     "time": "10:45",
    //     "unread": 0,
    //     "online": false,
    //   },
    //   {
    //     "name": "Burger Hub",
    //     "message": "Your order will be ready in 15 mins.",
    //     "time": "Yesterday",
    //     "unread": 1,
    //     "online": true,
    //   },
    //   {
    //     "name": "Luxe Salon",
    //     "message": "Can we reschedule your appointment?",
    //     "time": "Monday",
    //     "unread": 0,
    //     "online": false,
    //   },
    // ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Messages",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Chat with businesses",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),

                const Spacer(),

                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    switch (value) {
                      case 'read':
                        break;
                      case 'settings':
                        break;
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'read',
                      child: Text('Mark all as read'),
                    ),
                    PopupMenuItem(value: 'settings', child: Text('Settings')),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Search conversations',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.search, size: 25),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 25),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xffF5F5F5),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(color: Color(0xff0A4FD6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: StreamBuilder<List<ChatModel>>(
        stream: _message.getChats(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('${snapshot.error}');
            return Center(child: Text('Error Loading Messages'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Start a conversation'));
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });

          final chats = snapshot.data!;
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];

              return MessageTile(
                businessImage: chat.businessImage,
                businessName: chat.businessName,
                lastMessage: chat.lastMessage ?? '',
                time: chat.lastMessageTime == null
                    ? ''
                    : TimeOfDay.fromDateTime(
                        chat.lastMessageTime!,
                      ).format(context),
                unread: chat.unreadCount,
                online: false,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(chat: chat),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

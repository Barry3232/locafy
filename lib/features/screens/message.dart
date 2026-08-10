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
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'read':
                  // Mark all as read
                  break;
                case 'settings':
                  // Open settings
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'read', child: Text('Mark all as read')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),

      body: StreamBuilder<List<ChatModel>>(
        stream: _message.getChats(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error Loading Messages'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Start a conversation'));
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          final chats = snapshot.data!;
          return ListView.builder(
            // final chats = snapshot.data!;
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),

            itemCount: chats.length,

            itemBuilder: (context, index) {
              final chat = chats[index];

              return MessageTile(
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

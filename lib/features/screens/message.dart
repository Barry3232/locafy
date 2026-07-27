import 'package:flutter/material.dart';
import 'package:locafy/widgets/message_section/message_tile.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        "name": "Aroma Café",
        "message": "Your reservation is confirmed.",
        "time": "2m",
        "unread": 2,
        "online": true,
      },
      {
        "name": "Grand Hotel",
        "message": "Rooms are available this weekend.",
        "time": "10:45",
        "unread": 0,
        "online": false,
      },
      {
        "name": "Burger Hub",
        "message": "Your order will be ready in 15 mins.",
        "time": "Yesterday",
        "unread": 1,
        "online": true,
      },
      {
        "name": "Luxe Salon",
        "message": "Can we reschedule your appointment?",
        "time": "Monday",
        "unread": 0,
        "online": false,
      },
    ];

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

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search conversations",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];

                return MessageTile(
                  businessName: chat["name"] as String,
                  lastMessage: chat["message"] as String,
                  time: chat["time"] as String,
                  unread: chat["unread"] as int,
                  online: chat["online"] as bool,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

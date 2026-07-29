import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locafy/models/business_model.dart';

class ChatScreen extends StatefulWidget {
  final BusinessModel business;

  const ChatScreen({super.key, required this.business});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;

  // Temporary messages
  final List<Map<String, dynamic>> messages = [
    {"senderId": "business", "message": "Hello 👋", "time": "9:12 AM"},
    {"senderId": "me", "message": "Hi", "time": "9:13 AM"},
    {
      "senderId": "business",
      "message": "How may we help you today?",
      "time": "9:14 AM",
    },
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "senderId": "me",
        "message": messageController.text.trim(),
        "time": "Now",
      });
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.business.image),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.business.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    "Online",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),

          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),

      body: Column(
        children: [
          /// Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                final isMe = message["senderId"] == "me";

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),

                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .75,
                    ),

                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xff0A4FD6) : Colors.white,

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Text(
                          message["message"],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          message["time"],
                          style: TextStyle(
                            fontSize: 11,
                            color: isMe ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// Bottom Input
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),

              decoration: const BoxDecoration(color: Colors.white),

              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file),
                  ),

                  Expanded(
                    child: TextField(
                      controller: messageController,

                      decoration: InputDecoration(
                        hintText: "Type a message",

                        filled: true,
                        fillColor: Colors.grey.shade200,

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xff0A4FD6),

                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

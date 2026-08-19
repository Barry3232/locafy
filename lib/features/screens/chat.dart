import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/services/chat_services.dart';
import 'package:locafy/models/chat.dart';
import 'package:locafy/models/message.dart';

class ChatScreen extends StatefulWidget {
  // final BusinessModel business;
  final String chatId;
  final ChatModel chat;

  const ChatScreen({super.key, required this.chatId, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;
  final ChatServices _chatServices = ChatServices();

  @override
  void initState() {
    super.initState();

    _chatServices.markMessagesAsSeen(widget.chatId);
  }

  // Temporary messages
  final List<Map<String, dynamic>> demoMessages = [
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
      demoMessages.add({
        "senderId": "me",
        "message": messageController.text.trim(),
        "time": "Now",
      });
    });

    messageController.clear();
  }

  Widget _buildMessageBubble({
    required bool isMe,
    required String message,
    required String time,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                fontSize: 11,
                color: isMe ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
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
              backgroundImage: NetworkImage(widget.chat.businessImage),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.businessName,
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
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _chatServices.getMessages(widget.chat.id),
              builder: (context, snapshot) {
                final firebaseMessages = snapshot.data ?? [];

                final useDemo = firebaseMessages.isEmpty;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  itemCount: useDemo
                      ? demoMessages.length
                      : firebaseMessages.length,
                  itemBuilder: (context, index) {
                    if (useDemo) {
                      final message = demoMessages[index];

                      final isMe = message["senderId"] == "me";

                      return _buildMessageBubble(
                        isMe: isMe,
                        message: message["message"],
                        time: message["time"],
                      );
                    }

                    final message = firebaseMessages[index];

                    final isMe = message.senderId == currentUser.uid;

                    return _buildMessageBubble(
                      isMe: isMe,
                      message: message.text,
                      time: TimeOfDay.fromDateTime(
                        message.createdAt,
                      ).format(context),
                    );
                  },
                );
              },
            ),
          ),
          //     /// Bottom Input
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
                      onPressed: () async {
                        if (messageController.text.trim().isEmpty) return;

                        await _chatServices.sendMessage(
                          chatId: widget.chat.id,
                          receiverId: widget.chat.ownerId,
                          text: messageController.text,
                        );
                        messageController.clear();
                      },
                      // sendMessage,
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

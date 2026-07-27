import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String businessName;
  final String lastMessage;
  final String time;
  final int unread;
  final bool online;

  const MessageTile({
    super.key,
    required this.businessName,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xff0A4FD6),
                  child: Icon(Icons.store, color: Colors.white),
                ),

                if (online)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    businessName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 8),

                if (unread > 0)
                  CircleAvatar(
                    radius: 11,
                    backgroundColor: const Color(0xff0A4FD6),

                    child: Text(
                      unread.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

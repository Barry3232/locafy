import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/models/chat.dart';
import 'package:locafy/models/message.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<ChatModel> createChat(BusinessModel business) async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      throw Exception("User is not logged in");
    }

    final chatId = "${currentUser.uid}_${business.id}";

    final chatRef = _firestore.collection("chats").doc(chatId);
    final chatSnapshot = await chatRef.get();

    if (chatSnapshot.exists) {
      return ChatModel.fromFirestore(chatSnapshot);
    }

    final chat = ChatModel(
      id: chatId,
      businessId: business.id,
      businessName: business.name,
      businessImage: business.image,
      customerId: currentUser.uid,
      ownerId: business.ownerId,
      lastMessage: "",
      lastMessageTime: DateTime.now(),
      unreadCount: 0,
      lastMessageSenderId: "",
    );

    await chatRef.set(chat.toFirestore());

    return chat;
  }

  Future<void> sendMessage({
    required String chatId,
    required String receiverId,
    required String text,
  }) async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      throw Exception("User not logged in");
    }

    if (text.trim().isEmpty) return;

    final chatRef = _firestore.collection("chats").doc(chatId);

    final messageRef = chatRef.collection("messages").doc();

    final message = MessageModel(
      id: messageRef.id,
      senderId: currentUser.uid,
      receiverId: receiverId,
      text: text.trim(),
      createdAt: DateTime.now(),
      seen: false,
    );

    // Save the message
    await messageRef.set(message.toFirestore());

    // Update the chat preview
    await chatRef.update({
      "lastMessage": text.trim(),
      "lastMessageTime": FieldValue.serverTimestamp(),
      "lastMessageSenderId": currentUser.uid,
      "unreadCount": FieldValue.increment(1),
    });
  }

  Stream<List<ChatModel>> getChats() {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection("chats")
        .where("customerId", isEqualTo: currentUser.uid)
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatModel.fromFirestore(doc))
              .toList();
        });
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return Stream.empty();
    }
    return _firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("createdAt")
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList();
        });
  }
}

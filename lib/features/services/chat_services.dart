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
      ownerUnreadCount: 0,
      customerUnreadCount: 0,
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
    final chatSnapshot = await chatRef.get();
    final chat = ChatModel.fromFirestore(chatSnapshot);
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
    if (currentUser.uid == chat.customerId) {
      await chatRef.update({
        "lastMessage": text.trim(),
        "lastMessageTime": FieldValue.serverTimestamp(),
        "lastMessageSenderId": currentUser.uid,
        "ownerUnreadCount": FieldValue.increment(1),
      });
    } else if (currentUser.uid == chat.ownerId) {
      await chatRef.update({
        "lastMessage": text.trim(),
        "lastMessageTime": FieldValue.serverTimestamp(),
        "lastMessageSenderId": currentUser.uid,
        "customerUnreadCount": FieldValue.increment(1),
      });
    }
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

  Future<void> markMessagesAsSeen(String chatId) async {
    final currentUser = _firebaseAuth.currentUser!;
    final messageRef = _firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages");

    final snapshot = await messageRef
        .where("receiverId", isEqualTo: currentUser.uid)
        .where("seen", isEqualTo: false)
        .get();

    for (final doc in snapshot.docs) {
      // final message = MessageModel.fromFirestore(doc);
      // print(message.text);
      await doc.reference.update({"seen": true});
    }

    final chatSnapshot = await _firestore.collection("chats").doc(chatId).get();

    final chat = ChatModel.fromFirestore(chatSnapshot);
    if (chat.customerId == currentUser.uid) {
      await _firestore.collection("chats").doc(chatId).update({
        "customerUnreadCount": 0,
      });
    } else if (chat.ownerId == currentUser.uid) {
      await _firestore.collection("chats").doc(chatId).update({
        "ownerUnreadCount": 0,
      });
    }
  }
}

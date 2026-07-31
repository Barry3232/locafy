import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/models/business_model.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> createChat(BusinessModel business) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception("User is not logged in");
    }
    final chatId = "${currentUser.uid}_${business.id}";
    final chatRef = _firestore.collection("chats").doc(chatId);
    final chatSnapshot = await chatRef.get();

    if (chatSnapshot.exists) {
      return chatId;
    }
    await chatRef.set({
      "businessId": business.id,
      "businessName": business.name,
      "businessImage": business.image,
      "customerId": currentUser.uid,
      "ownerId": business.ownerId,
      "lastMessage": "",
      "lastMessageTime": FieldValue.serverTimestamp(),
      "unreadCount": 0,
    });

    return chatId;
  }
}

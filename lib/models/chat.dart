import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String businessId;
  final String businessName;
  final String businessImage;
  final String customerId;
  final String ownerId;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int ownerUnreadCount;
  final int customerUnreadCount;
  final String lastMessageSenderId;

  ChatModel({
    required this.id,
    required this.businessId,
    required this.businessName,
    required this.businessImage,
    required this.customerId,
    this.lastMessage,
    this.lastMessageTime,
    required this.ownerUnreadCount,
    required this.customerUnreadCount,
    required this.ownerId,
    required this.lastMessageSenderId,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      businessId: data['businessId'] ?? '',
      businessName: data['businessName'] ?? '',
      businessImage: data['businessImage'] ?? '',
      customerId: data['customerId'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime:
          (data['lastMessageTime'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
      ownerUnreadCount: data['ownerUnreadCount'] ?? 0,
      customerUnreadCount: data['customerUnreadCount'] ?? 0,
      ownerId: data['ownerId'] ?? '',
      lastMessageSenderId: data['lastMessageSenderId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'businessId': businessId,
      'businessName': businessName,
      'businessImage': businessImage,
      'customerId': customerId,
      'ownerId': ownerId,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(lastMessageTime!),
      'ownerUnreadCount': ownerUnreadCount,
      'customerUnreadCount': customerUnreadCount,
      'lastMessageSenderId': lastMessageSenderId,
    };
  }
}

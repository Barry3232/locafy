import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String comment;
  final double rating;
  final String? userPhoto;
  final List<String> images;
  final DateTime createdAt;
  final int helpfulCount;
  final List<String> helpfulBy;

  ReviewModel({
    required this.images,
    this.userPhoto,
    required this.id,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.helpfulCount,
    required this.helpfulBy,
  });

  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userPhoto: data["userPhoto"],
      comment: data['comment'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      rating: (data['rating'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      helpfulCount: data['helpfulCount'] ?? 0,
      helpfulBy: List<String>.from(data["helpfulBy"] ?? []),
    );
  }
}

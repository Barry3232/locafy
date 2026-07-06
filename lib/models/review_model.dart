// class ReviewModel {
//   final String id;
//   final String userId;
//   final String userName;
//   final String comment;
//   final double rating;
//   final DateTime createdAt;

//   final int helpfulCount;
//   final int notHelpfulCount;

//   ReviewModel({
//     required this.id,
//     required this.userId,
//     required this.userName,
//     required this.comment,
//     required this.rating,
//     required this.createdAt,
//     required this.helpfulCount,
//     required this.notHelpfulCount,
//   });

//   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String docId) {
//     return ReviewModel(
//       id: docId,
//       userId: data['userId'] ?? '',
//       userName: data['userName'] ?? '',
//       comment: data['comment'] ?? '',
//       rating: (data['rating'] ?? 0).toDouble(),
//       createdAt: data['createdAt'].toDate(),
//       helpfulCount: data['helpfulCount'] ?? 0,
//       notHelpfulCount: data['notHelpfulCount'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'userId': userId,
//       'userName': userName,
//       'comment': comment,
//       'rating': rating,
//       'createdAt': createdAt,
//       'helpfulCount': helpfulCount,
//       'notHelpfulCount': notHelpfulCount,
//     };
//   }
// }

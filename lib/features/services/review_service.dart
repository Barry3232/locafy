import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locafy/models/review_model.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ReviewModel>> getReviews(String businessId) {
    return _firestore
        .collection("businesses")
        .doc(businessId)
        .collection("reviews")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ReviewModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<void> toggleHelpful({
    required String businessId,
    required String reviewId,
    required String userId,
  }) async {
    final reviewRef = FirebaseFirestore.instance
        .collection('businesses')
        .doc(businessId)
        .collection("reviews")
        .doc(reviewId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(reviewRef);
      final data = snapshot.data()!;
      List helpfulBy = List.from(data["helpfulBy"] ?? []);

      if (helpfulBy.contains(userId)) {
        helpfulBy.remove(userId);
      } else {
        helpfulBy.add(userId);
      }

      transaction.update(reviewRef, {
        "helpfulBy": helpfulBy,
        "helpfulCount": helpfulBy.length,
      });
    });
  }
}

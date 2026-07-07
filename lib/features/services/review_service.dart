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
}

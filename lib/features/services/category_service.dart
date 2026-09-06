import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/models/business_model.dart';

class CategoryService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<BusinessModel>> getCategory(List<String> category) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection("businesses")
        .where("category", whereIn: category)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BusinessModel.fromFirestore(doc))
              .toList(),
        );
  }
}

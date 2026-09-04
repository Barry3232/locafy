import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/models/business_model.dart';

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<BusinessModel>> searchBusinesses(String query) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return const Stream.empty();
    }
    if (query.trim().isEmpty) {
      return const Stream.empty();
    }
    return _firestore
        .collection('businesses')
        .where('businessName', isGreaterThanOrEqualTo: query)
        .where('businessName', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BusinessModel.fromFirestore(doc))
              .toList(),
        );
  }
}

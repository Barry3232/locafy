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
    final searchQuery = query.trim().toLowerCase();
    return _firestore
        .collection('businesses')
        .where('searchName', isGreaterThanOrEqualTo: searchQuery)
        .where('searchName', isLessThanOrEqualTo: '$searchQuery\uf8ff')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BusinessModel.fromFirestore(doc))
              .toList(),
        );
  }

  // Future<void> migrateBusinessSearchNames() async {
  //   final snapshot = await _firestore.collection('businesses').get();

  //   for (final doc in snapshot.docs) {
  //     final data = doc.data();

  //     final businessName = data['businessName'];

  //     if (businessName == null) {
  //       continue;
  //     }

  //     await doc.reference.update({
  //       'searchName': businessName.toString().trim().toLowerCase(),
  //     });
  //   }
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/models/business_model.dart';

class CategoryService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getCategory(BusinessModel business) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("User is not logged in");
    }

    final businesses = await FirebaseFirestore.instance
        .collection("businesses")
        .where("category", isEqualTo: business.category)
        .get();

    if (businesses.docs.isEmpty) {
      throw Exception("No businesses found for this category");
    }
  }
}

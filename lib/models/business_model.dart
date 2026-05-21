import 'package:locafy/models/features_model.dart';

class BusinessModel {
  final String name;
  final String image;
  final String category;
  final String distance;
  final String rating;
  final int reviewsCount;
  final String description;
  final String location;
  final List<FeaturesModel> features;

  BusinessModel({
    required this.name,
    required this.image,
    required this.category,
    required this.distance,
    required this.rating,
    required this.location,
    required this.reviewsCount,
    required this.description,
    required this.features,
  });
}

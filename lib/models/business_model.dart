import 'package:locafy/models/features_model.dart';
import 'package:locafy/models/pictures_modle.dart';

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
  final List<PicturesModel> picture;

  final int fiveStar;
  final int fourStar;
  final int threeStar;
  final int twoStar;
  final int oneStar;

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
    required this.picture,
    required this.fiveStar,
    required this.fourStar,
    required this.threeStar,
    required this.twoStar,
    required this.oneStar,
  });
}

import 'package:locafy/models/features_model.dart';
import 'package:locafy/models/pictures_modle.dart';

class BusinessModel {
  final String name;
  final String image;
  final String category;
  final String? distanc;
  double? distance;
  final String? rating;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? reviewsCount;
  final String description;
  final String location;
  final List<FeaturesModel> features;
  final List<PicturesModel> picture;

  final int? fiveStar;
  final int? fourStar;
  final int? threeStar;
  final int? twoStar;
  final int? oneStar;

  BusinessModel({
    required this.name,
    required this.image,
    required this.category,
    this.distanc,
    this.distance,
    this.rating,
    required this.location,
    this.address,
    this.latitude,
    this.longitude,
    this.reviewsCount,
    required this.description,
    required this.features,
    required this.picture,
    this.fiveStar,
    this.fourStar,
    this.threeStar,
    this.twoStar,
    this.oneStar,
  });

  factory BusinessModel.fromFirestore(Map<String, dynamic> data) {
    return BusinessModel(
      name: data['businessName'] ?? '',
      image: data['coverPhotoUrl'] ?? '',
      category: data['category'] ?? '',
      location: data['address'] ?? '',
      description: data['description'] ?? '',
      address: data['address'],
      latitude: data['latitude'],
      longitude: data['longitude'],

      distance: null,
      rating: '0.0',

      reviewsCount: 0,

      features: [],
      picture: [],
    );
  }
}

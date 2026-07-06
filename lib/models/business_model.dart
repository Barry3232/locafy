import 'package:locafy/models/features_model.dart';
import 'package:locafy/models/pictures_modle.dart';

import 'package:locafy/widgets/details_section/amenities_icon.dart';

class BusinessModel {
  final String? id;
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
  final String? openingHours;
  final List<FeaturesModel> features;
  final List<PicturesModel> picture;

  final int? fiveStar;
  final int? fourStar;
  final int? threeStar;
  final int? twoStar;
  final int? oneStar;

  BusinessModel({
    this.id,
    this.openingHours,
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

  factory BusinessModel.fromFirestore(String id, Map<String, dynamic> data) {
    return BusinessModel(
      id: id,
      name: data['businessName'] ?? '',
      image: data['coverPhotoUrl'] ?? '',
      category: data['category'] ?? '',
      location: data['address'] ?? '',
      description: data['description'] ?? '',
      address: data['address'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      openingHours: data['openingHours'] ?? '',
      distance: null,
      rating: '0.0',
      reviewsCount: 0,
      features:
          (data['amenities'] as List?)
              ?.map(
                (item) => FeaturesModel(name: item, icon: getAmenityIcon(item)),
              )
              .toList() ??
          [],
      picture:
          (data['businessImages'] as List?)
              ?.map((url) => PicturesModel(image: url))
              .toList() ??
          [],
    );
  }
}

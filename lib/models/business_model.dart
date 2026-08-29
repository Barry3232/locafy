import 'package:locafy/models/features_model.dart';
import 'package:locafy/models/pictures_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locafy/widgets/details_section/amenities_icon.dart';
import 'package:geolocator/geolocator.dart';

class BusinessModel {
  final String ownerId;
  final String id;
  final String name;
  final String image;
  final String category;
  final String? distanc;
  final double? distance;
  final String? rating;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? reviewsCount;
  final double? averageRating;
  final String description;
  final String? phoneNumber;
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
    required this.ownerId,
    required this.id,
    this.openingHours,
    required this.name,
    required this.image,
    required this.category,
    this.distanc,
    this.distance,
    this.averageRating,
    this.rating,
    required this.location,
    this.address,
    this.latitude,
    this.longitude,
    this.phoneNumber,
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

  factory BusinessModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BusinessModel(
      id: doc.id,
      ownerId: data['ownerId'] ?? '',
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
      phoneNumber: data["phoneNumber"],
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

  String getFormattedDistance(Position? userPosition) {
    if (userPosition == null || latitude == null || longitude == null) {
      return distanc ?? '0 m away';
    }

    final meters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      latitude!,
      longitude!,
    );

    if (meters < 1000) {
      return '${meters.round()} m away';
    }

    return '${(meters / 1000).toStringAsFixed(1)} km';
  }
}

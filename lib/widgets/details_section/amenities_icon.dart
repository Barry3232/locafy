import 'package:flutter/material.dart';

IconData getAmenityIcon(String amenity) {
  switch (amenity) {
    case 'Wi-Fi':
      return Icons.wifi;

    case 'Parking':
      return Icons.local_parking_outlined;

    case 'Delivery':
      return Icons.delivery_dining_outlined;

    case 'Reservations':
      return Icons.event_seat_outlined;

    case 'Pet Friendly':
      return Icons.pets_outlined;

    case 'Takeaway':
      return Icons.shopping_bag_outlined;

    case 'Wheelchair Accessible':
      return Icons.accessible_outlined;

    case 'Outdoor Seating':
      return Icons.deck_outlined;

    case 'Air Conditioning':
      return Icons.ac_unit_outlined;

    default:
      return Icons.check;
  }
}

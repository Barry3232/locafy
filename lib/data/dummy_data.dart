import 'package:locafy/models/business_model.dart';
import 'package:locafy/models/features_model.dart';
import 'package:flutter/material.dart';
import 'package:locafy/models/pictures_modle.dart';

List<BusinessModel> businesses = [
  BusinessModel(
    id: 'Business_1',
    ownerId: '123',
    name: 'Shoprite',
    image: 'assets/images/grocery.jpg',
    category: 'Shop',
    distanc: '0.5 km away',
    rating: '4.6',
    reviewsCount: 12,
    fiveStar: 16,
    fourStar: 3,
    threeStar: 1,
    twoStar: 0,
    oneStar: 0,
    description:
        'A modern supermarket offering a wide variety of groceries, fresh produce, household essentials, beverages, snacks, electronics, and personal care products. Shoprite provides a clean and organized shopping environment with affordable prices, friendly customer service, and convenient checkout options, making it a reliable destination for everyday shopping needs.',
    location: '123 Choba Road, Port Harcourt, Rivers State',
    features: [
      FeaturesModel(icon: Icons.wifi, name: 'Free WiFi'),

      FeaturesModel(icon: Icons.local_parking, name: 'Parking'),

      FeaturesModel(icon: Icons.delivery_dining, name: 'Delivery'),
    ],
    picture: [
      PicturesModel(image: 'assets/images/shoprite.jpg'),
      PicturesModel(image: 'assets/images/shoprite1.jpg'),

      PicturesModel(image: 'assets/images/food5.jpg'),
      PicturesModel(image: 'assets/images/shoprite1.jpg'),
    ],
  ),

  BusinessModel(
    id: 'Business_2',
    ownerId: '12',
    name: 'Genesis Cafe',
    image: 'assets/images/Genesis.jpg',
    category: 'Restaurant',
    distanc: '1 km away',
    rating: '4.8',
    reviewsCount: 20,
    fiveStar: 16,
    fourStar: 3,
    threeStar: 1,
    twoStar: 0,
    oneStar: 0,
    description:
        'A cozy and stylish cafe known for its delicious meals, freshly brewed coffee, pastries, and refreshing drinks. Genesis Cafe offers a calm and welcoming atmosphere perfect for casual hangouts, business meetings, studying, or relaxing with friends and family. Customers enjoy its quality service, comfortable seating, and carefully prepared menu options.',
    location: '123 Choba Road, Port Harcourt, Rivers State',

    features: [
      FeaturesModel(icon: Icons.wifi, name: 'Free WiFi'),

      FeaturesModel(icon: Icons.coffee, name: 'Coffee'),

      FeaturesModel(icon: Icons.delivery_dining, name: 'Delivery'),

      FeaturesModel(icon: Icons.event_seat, name: 'Indoor Seating'),
    ],
    picture: [
      PicturesModel(image: 'assets/images/food3.jpg'),
      PicturesModel(image: 'assets/images/food4.jpg'),
      PicturesModel(image: 'assets/images/food.jpg'),
      PicturesModel(image: 'assets/images/food5.jpg'),
    ],
  ),

  BusinessModel(
    id: 'Business_3',
    ownerId: '1',
    name: 'Kilimanjaro Cafe',
    image: 'assets/images/kilimanjaro.jpg',
    category: 'Restaurant',
    distanc: '2 km away',
    rating: '3.8',
    reviewsCount: 13,
    fiveStar: 9,
    fourStar: 1,
    threeStar: 1,
    twoStar: 2,
    oneStar: 0,
    description:
        'A popular fast-food restaurant serving a variety of tasty local and continental dishes in a clean and comfortable environment. Kilimanjaro Cafe is well known for its quick customer service, affordable meals, and relaxing dining experience, making it a favorite spot for breakfast, lunch, and dinner outings.',
    location: '123 Choba Road, Port Harcourt, Rivers State',
    features: [
      FeaturesModel(icon: Icons.fastfood, name: 'Fast Food'),

      FeaturesModel(icon: Icons.takeout_dining, name: 'Takeaway'),

      FeaturesModel(icon: Icons.family_restroom, name: 'Family Friendly'),

      FeaturesModel(icon: Icons.access_time, name: '24/7 Service'),
    ],
    picture: [
      PicturesModel(image: 'assets/images/kilimanjaro.jpg'),
      PicturesModel(image: 'assets/images/food5.jpg'),
      PicturesModel(image: 'assets/images/food4.jpg'),
      PicturesModel(image: 'assets/images/food.jpg'),
      PicturesModel(image: 'assets/images/food3.jpg'),
    ],
  ),

  BusinessModel(
    id: 'Business_4',
    ownerId: '0',
    name: 'The Boss Store',
    image: 'assets/images/The Boss store.jpg',
    category: 'Shop',
    distanc: '10 km away',
    rating: '3.5',
    reviewsCount: 13,
    fiveStar: 5,
    fourStar: 3,
    threeStar: 1,
    twoStar: 2,
    oneStar: 2,
    description:
        'A trendy fashion store offering stylish clothing, footwear, bags, wristwatches, and accessories for both men and women. The Boss Store focuses on modern fashion and affordable luxury, providing customers with quality outfits suitable for casual outings, office wear, and special occasions.',
    location: '123 Choba Road, Port Harcourt, Rivers State',

    features: [
      FeaturesModel(icon: Icons.checkroom, name: 'Fashion'),

      FeaturesModel(icon: Icons.shopping_bag, name: 'Accessories'),

      FeaturesModel(icon: Icons.discount, name: 'Discount Sales'),

      FeaturesModel(icon: Icons.payments, name: 'POS Payment'),
    ],
    picture: [PicturesModel(image: 'assets/images/The Boss store.jpg')],
  ),

  BusinessModel(
    id: 'Business_5',
    ownerId: '1234',
    name: 'PMP Resort',
    image: 'assets/images/resort.jpg',
    category: 'Resort',
    distanc: '5 km away',
    rating: '4.5',
    reviewsCount: 10,
    fiveStar: 3,
    fourStar: 3,
    threeStar: 2,
    twoStar: 2,
    oneStar: 0,
    description:
        'A relaxing luxury resort featuring spacious rooms, swimming pools, outdoor lounges, recreational activities, and beautiful scenery. PMP Resort provides a peaceful environment for vacations, weekend getaways, family gatherings, and private events while delivering quality hospitality and premium customer service.',
    location: '123 Choba Road, Port Harcourt, Rivers State',

    features: [
      FeaturesModel(icon: Icons.pool, name: 'Swimming Pool'),

      FeaturesModel(icon: Icons.hotel, name: 'Luxury Rooms'),

      FeaturesModel(icon: Icons.restaurant, name: 'Restaurant'),

      FeaturesModel(icon: Icons.sports_bar, name: 'Lounge Bar'),

      FeaturesModel(icon: Icons.wifi, name: 'Free WiFi'),
    ],
    picture: [
      PicturesModel(image: 'assets/images/resort.jpg'),
      PicturesModel(image: 'assets/images/resorts.jpg'),
      PicturesModel(image: 'assets/images/resorts1.jpg'),
      PicturesModel(image: 'assets/images/food.jpg'),
      PicturesModel(image: 'assets/images/food5.jpg'),
    ],
  ),

  BusinessModel(
    id: 'Business_6',
    ownerId: '21',
    name: "Milo's Resort",
    image: 'assets/images/resort1.jpg',
    category: 'Resort',
    distanc: '5 km away',
    rating: '4.5',
    reviewsCount: 13,
    fiveStar: 9,
    fourStar: 1,
    threeStar: 1,
    twoStar: 2,
    oneStar: 0,
    description:
        'A peaceful and elegant resort offering premium hospitality services, comfortable accommodations, entertainment facilities, and relaxing outdoor spaces. Milo’s Resort is designed to give visitors a calm and enjoyable experience with quality food services, modern rooms, and friendly staff support.',
    location: '123 Choba Road, Port Harcourt, Rivers State',
    features: [
      FeaturesModel(icon: Icons.pool, name: 'Swimming Pool'),
      FeaturesModel(icon: Icons.hotel, name: 'Luxury Rooms'),
      FeaturesModel(icon: Icons.restaurant, name: 'Restaurant'),
      FeaturesModel(icon: Icons.sports_bar, name: 'Lounge Bar'),
    ],
    picture: [
      PicturesModel(image: 'assets/images/resort1.jpg'),
      PicturesModel(image: 'assets/images/resorts2.jpg'),
      PicturesModel(image: 'assets/images/resorts3.jpg'),
      PicturesModel(image: 'assets/images/food.jpg'),
      PicturesModel(image: 'assets/images/food5.jpg'),
    ],
  ),

  BusinessModel(
    id: 'Business_7',
    ownerId: '43',
    name: "Milo's Barber Shop",
    image: 'assets/images/Barbershop.jpg',
    category: 'Shop',
    distanc: '120 km away',
    rating: '4.5',
    reviewsCount: 10,
    fiveStar: 6,
    fourStar: 1,
    threeStar: 1,
    twoStar: 2,
    oneStar: 0,
    description:
        'A modern barber shop providing professional haircuts, beard grooming, hair styling, and skincare services in a clean and relaxing environment. Milo’s Barber Shop is known for its skilled barbers, attention to detail, excellent customer service, and stylish grooming experience for all ages.',
    location: '123 Choba Road, Port Harcourt, Rivers State',
    features: [
      FeaturesModel(icon: Icons.content_cut, name: 'Haircuts'),
      FeaturesModel(icon: Icons.face, name: 'Beard Grooming'),
      FeaturesModel(icon: Icons.style, name: 'Hair Styling'),
      FeaturesModel(icon: Icons.spa, name: 'Skincare Services'),
    ],
    picture: [PicturesModel(image: 'assets/images/Barbershop.jpg')],
  ),

  BusinessModel(
    id: 'Business_8',
    ownerId: '34',
    name: "Milo's Cloth Shop",
    image: 'assets/images/cloths.jpg',
    category: 'Shop',
    distanc: '120 km away',
    rating: '3.5',
    reviewsCount: 13,
    fiveStar: 9,
    fourStar: 1,
    threeStar: 1,
    twoStar: 2,
    oneStar: 0,
    description:
        'A fashion store specializing in quality clothing, trendy streetwear, shoes, and stylish outfits for customers looking for modern and classy fashion. Milo’s Cloth Shop offers a wide range of fashionable collections with quality materials, affordable prices, and excellent customer service.',
    location: '123 Choba Road, Port Harcourt, Rivers State',
    features: [
      FeaturesModel(icon: Icons.checkroom, name: 'Clothing'),
      FeaturesModel(icon: Icons.shopping_bag, name: 'Accessories'),
      FeaturesModel(icon: Icons.discount, name: 'Discount Sales'),
      FeaturesModel(icon: Icons.payments, name: 'POS Payment'),
    ],
    picture: [PicturesModel(image: 'assets/images/cloths.jpg')],
  ),
];

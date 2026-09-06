import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locafy/features/screens/details.dart';
import 'package:locafy/features/services/category_service.dart';
import 'package:locafy/widgets/home_section/category_wiget.dart';

class CategoriesScreen extends StatefulWidget {
  // final BusinessModel business;
  final List<String> category;
  final IconData icon;
  final String title;
  final Color color;
  final Color iconColor;
  const CategoriesScreen({
    super.key,
    required this.category,
    required this.icon,
    required this.title,
    required this.color,
    required this.iconColor,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Position? userPosition; // Store the position here

  @override
  void initState() {
    super.initState();
    getUserLocation(); // Fetch location when screen loads
  }

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        userPosition = position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: CategoryService().getCategory(widget.category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/house.png'),
                      height: 200,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No businesses found',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      textAlign: TextAlign.center,
                      'We couldn\'t find any businesses in this category yet.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            final businesses = snapshot.data!;

            return ListView.builder(
              itemCount: businesses.length + 1,
              itemBuilder: (context, index) {
                // Header
                if (index == 0) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: widget.color,
                            child: Icon(
                              widget.icon,
                              size: 30,
                              color: widget.iconColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${businesses.length} "
                                "${businesses.length == 1 ? 'business' : 'businesses'} found",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                }

                // Business
                final business = businesses[index - 1];

                final distanceCal = business.getFormattedDistance(userPosition);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CategoryWidget(
                    category: business.category,
                    image: business.image,
                    businessName: business.name,
                    distance: "$distanceCal km",
                    rating: "${business.rating}",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                            business: business,
                            distanceText: "$distanceCal km",
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

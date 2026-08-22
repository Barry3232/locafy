import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/services/category_service.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/widgets/home_section/category_wiget.dart';

class CategoriesScreen extends StatefulWidget {
  // final BusinessModel business;
  final String category;
  const CategoriesScreen({super.key, required this.category});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
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
              return const Center(child: Text('No businesses found.'));
            }

            final businesses = snapshot.data!;

            return ListView.builder(
              itemCount: businesses.length,
              itemBuilder: (context, index) {
                final business = businesses[index];
                return CategoryWidget(
                  category: business.category,
                  image: business.image,
                  businessName: business.name,
                  distance: "${business.distance} km",
                  rating: "${business.rating} ",
                  onTap: () {
                    // Handle tap event, e.g., navigate to business details
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

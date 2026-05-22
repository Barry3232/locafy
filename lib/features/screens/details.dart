import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/widgets/details_section/enquiry_items.dart';
import 'package:locafy/widgets/details_section/features_items.dart';

class DetailsScreen extends StatelessWidget {
  final BusinessModel business;
  const DetailsScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(business.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Spacer(),

                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.57,
            minChildSize: 0.57,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            business.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 5),
                          Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF0A4FD6),
                            size: 22,
                          ),
                        ],
                      ),

                      SizedBox(height: 5),

                      Row(
                        children: [
                          Text(
                            business.category,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                          CircleAvatar(radius: 3),
                          SizedBox(width: 5),
                          Text(
                            business.distance,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),

                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.orange),
                          SizedBox(width: 4),
                          Text(
                            "${business.rating} (${business.reviewsCount} reviews)",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 10),

                          Container(
                            height: 16,
                            width: 1,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Open Now",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            EnquiryItems(
                              onTap: () {},
                              icon: Icons.phone,
                              text: 'Call',
                            ),
                            Spacer(),
                            EnquiryItems(
                              onTap: () {},
                              icon: Icons.near_me_outlined,
                              text: 'Directions',
                            ),
                            Spacer(),
                            EnquiryItems(
                              onTap: () {},
                              icon: Icons.language,
                              text: 'Website',
                            ),
                            Spacer(),
                            EnquiryItems(
                              onTap: () {},
                              icon: Icons.share,
                              text: 'Share',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      Container(
                        height: 80,
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF0A4FD6)),

                            SizedBox(width: 8),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  business.location,
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 5),

                                Text(
                                  business.distance,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),

                            Spacer(),

                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),

                      SizedBox(height: 5),

                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.access_time, color: Color(0xFF0A4FD6)),
                            SizedBox(width: 8),

                            Text(
                              business.location,
                              style: TextStyle(fontSize: 13),
                            ),

                            Spacer(),

                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),

                      SizedBox(height: 45),

                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(business.description),

                      SizedBox(height: 45),

                      Text(
                        'Features',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: business.features.map((feature) {
                          return FeaturesItems(
                            name: feature.name,
                            icon: feature.icon,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:locafy/models/business_model.dart';

class RecommendedItems extends StatelessWidget {
  final BusinessModel business;
  final VoidCallback? onTap;
  const RecommendedItems({super.key, required this.business, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 3),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(business.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(width: 8),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          business.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              business.category,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 4),
                            CircleAvatar(
                              radius: 2,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: 4),

                            Text(
                              business.distance,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.black, size: 14),
                            SizedBox(width: 4),
                            Text(
                              business.rating,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Spacer(),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

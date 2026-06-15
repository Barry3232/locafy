import 'package:flutter/material.dart';
import 'package:locafy/models/business_model.dart';

class PopularGridItem extends StatelessWidget {
  final BusinessModel business;
  final VoidCallback onTap;

  const PopularGridItem({
    super.key,
    required this.business,
    required this.onTap,
  });

  ImageProvider getBusinessImage(String image) {
    if (image.startsWith('http')) {
      return NetworkImage(image);
    }

    return AssetImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: getBusinessImage(business.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    color: Colors.white.withValues(alpha: 0.3),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.name,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        SizedBox(height: 5),
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
                              business.distanc!,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(
                              business.rating!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '(${business.reviewsCount})',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),

                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Open',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF0A4FD6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

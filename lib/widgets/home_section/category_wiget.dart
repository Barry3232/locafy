import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  // final BusinessModel business;
  final VoidCallback? onTap;
  final String category;
  final String image;
  final String businessName;
  final String distance;
  final String rating;
  const CategoryWidget({
    super.key,
    this.onTap,
    required this.category,
    required this.image,
    required this.businessName,
    required this.distance,
    required this.rating,
  });

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
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                blurRadius: 3,
              ),
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
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: image.startsWith('http')
                            ? Image.network(
                                image,
                                fit: BoxFit.cover,

                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }

                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.grey.shade200,
                                        ),

                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },

                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Image.asset(image, fit: BoxFit.cover),
                      ),
                    ),

                    SizedBox(width: 8),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          //
                          businessName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              //
                              category,
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
                              //
                              distance,
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
                              rating,
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

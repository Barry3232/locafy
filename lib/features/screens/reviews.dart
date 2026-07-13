import 'package:flutter/material.dart';
import 'package:locafy/features/services/review_service.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/models/review_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_auth/firebase_auth.dart';

class AllReviews extends StatefulWidget {
  final BusinessModel business;
  const AllReviews({super.key, required this.business});
  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: const Text("All Reviews"),
        backgroundColor: const Color(0xFFF2F4F7),
      ),

      body: StreamBuilder<List<ReviewModel>>(
        stream: ReviewService().getReviews(widget.business.id),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final reviews = snapshot.data!;
          // final allReviews = snapshot.data!;
          // final reviews = allReviews.skip(3).toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                final uid = FirebaseAuth.instance.currentUser!.uid;
                final isHelpful = review.helpfulBy.contains(uid);

                return Card(
                  elevation: 1,
                  shadowColor: Colors.grey,
                  color: Colors.white,

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  review.userPhoto != null &&
                                      review.userPhoto!.isNotEmpty
                                  ? NetworkImage(review.userPhoto!)
                                  : null,
                              child:
                                  review.userPhoto == null ||
                                      review.userPhoto!.isEmpty
                                  ? Text(
                                      review.userName[0].toUpperCase(),

                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(review.userName),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 20,
                                      width: 65,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          176,
                                          185,
                                          241,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.verified,
                                            size: 11,
                                            color: Colors.indigo,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Verified',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(timeago.format(review.createdAt)),
                              ],
                            ),
                            SizedBox(width: 5),
                            Spacer(),
                            ...List.generate(
                              5,
                              (index) => Icon(
                                index < review.rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color: index < review.rating.round()
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(review.comment),
                        SizedBox(height: 8),
                        if (review.images.isNotEmpty)
                          SizedBox(
                            height: 70,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: review.images.length,
                              separatorBuilder: (_, __) => SizedBox(width: 8),
                              itemBuilder: (context, imageIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          backgroundColor: Colors.black,
                                          insetPadding: const EdgeInsets.all(
                                            10,
                                          ),
                                          child: InteractiveViewer(
                                            minScale: 1,
                                            maxScale: 5,
                                            child: Image.network(
                                              review.images[imageIndex],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      review.images[imageIndex],
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        SizedBox(height: 8),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(left: 4),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            ReviewService().toggleHelpful(
                              businessId: '${widget.business.id}',
                              reviewId: review.id,
                              userId: uid,
                            );
                          },
                          icon: Icon(
                            isHelpful
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined,
                            color: isHelpful ? Color(0xFF0A4FD6) : Colors.grey,
                          ),

                          label: Text("${review.helpfulCount}"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

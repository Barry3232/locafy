import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/screens/reviews.dart';
import 'package:locafy/features/services/review_service.dart';
import 'package:locafy/models/review_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:locafy/models/business_model.dart';

class CommentSection extends StatefulWidget {
  final BusinessModel business;
  const CommentSection({super.key, required this.business});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  // Widget starButton(int index) {
  //   return IconButton(
  //     onPressed: () {

  //     },
  //     icon: Icon(Icons.star, color: Colors.amber),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ReviewModel>>(
      stream: ReviewService().getReviews('${widget.business.id}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFF0A4FD6)),
          );
        }

        final reviews = snapshot.data!;
        final previewReviews = reviews.take(3).toList();
        return Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reviews (${reviews.length})",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(
                        "2.5",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 13),
                      Text("(${reviews.length} review)"),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: previewReviews.length,
                    itemBuilder: (context, index) {
                      final review = previewReviews[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 8),
                                    itemBuilder: (context, imageIndex) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return Dialog(
                                                backgroundColor: Colors.black,
                                                insetPadding:
                                                    const EdgeInsets.all(10),
                                                child: InteractiveViewer(
                                                  minScale: 1,
                                                  maxScale: 5,
                                                  child: Image.network(
                                                    review.images[imageIndex],
                                                    fit: BoxFit.contain,
                                                    loadingBuilder:
                                                        (
                                                          context,
                                                          child,
                                                          loadingProgress,
                                                        ) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;

                                                          return Container(
                                                            width: 70,
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            child: const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Container(
                                                            width: 70,
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            child: const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .image_not_supported_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Text(
                                                                  "No Image",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.network(
                                            review.images[imageIndex],
                                            width: 70,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    width: 70,
                                                    color: Colors.grey.shade200,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons
                                                            .image_not_supported_outlined,
                                                        size: 35,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  );
                                                },
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                                  color: isHelpful
                                      ? Color(0xFF0A4FD6)
                                      : Colors.grey,
                                ),

                                label: Text("${review.helpfulCount}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 4),
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AllReviews(business: widget.business),
                        ),
                      );
                    },
                    child: Text(
                      'See all Reviews',
                      style: TextStyle(color: Color(0xFF0A4FD6)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

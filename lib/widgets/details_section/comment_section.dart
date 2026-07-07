import 'package:flutter/material.dart';
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
  Widget starButton(int index) {
    return IconButton(
      onPressed: () {
        // setState(() {
        //   _isSelected = !_isSelected;
        // });
      },
      icon: Icon(Icons.star, color: Colors.amber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ReviewModel>>(
      stream: ReviewService().getReviews('${widget.business.id}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final reviews = snapshot.data!;
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
                      SizedBox(width: 15),
                      Text("(${reviews.length} review)"),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
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
                                      Text(review.userName),
                                      Text(timeago.format(review.createdAt)),
                                    ],
                                  ),
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
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          review.images[imageIndex],
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              SizedBox(height: 8),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                style: IconButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {},
                                icon: Icon(Icons.thumb_up_off_alt_rounded),
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
                    onPressed: () {},
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

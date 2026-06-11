import 'package:flutter/material.dart';
import 'package:locafy/features/screens/full_image.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/widgets/details_section/enquiry_items.dart';
import 'package:locafy/widgets/details_section/features_items.dart';
import 'package:locafy/widgets/details_section/picture_items.dart';
import 'package:locafy/widgets/details_section/review_card.dart';

class DetailsScreen extends StatefulWidget {
  final BusinessModel business;

  const DetailsScreen({super.key, required this.business});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Widget ratingRow({
    required int star,
    required int value,
    required int total,
  }) {
    return Row(
      children: [
        Text('$star'),

        const SizedBox(width: 4),

        const Icon(Icons.star, size: 14, color: Colors.orange),

        const SizedBox(width: 8),

        Expanded(
          child: LinearProgressIndicator(
            value: value / total,
            backgroundColor: Colors.grey.shade300,
            color: Colors.orange,
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(width: 8),

        Text(value.toString()),
      ],
    );
  }

  bool showAllReviews = false;

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
                image: AssetImage(widget.business.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
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
                            widget.business.name,
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
                            widget.business.category,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                          CircleAvatar(radius: 3),
                          SizedBox(width: 5),
                          Text(
                            widget.business.distance!,
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
                            "${widget.business.rating} (${widget.business.reviewsCount} reviews)",
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
                            color: Colors.grey.withValues(alpha: 0.5),
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
                              icon: Icons.message_outlined,
                              text: 'Message',
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
                          color: Colors.grey.withValues(alpha: 0.2),
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
                                  widget.business.location,
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 5),

                                Text(
                                  widget.business.distance!,
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
                          color: Colors.grey.withValues(alpha: 0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.access_time, color: Color(0xFF0A4FD6)),
                            SizedBox(width: 8),

                            Text(
                              widget.business.location,
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

                      Text(widget.business.description),

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
                        children: widget.business.features.map((feature) {
                          return FeaturesItems(
                            name: feature.name,
                            icon: feature.icon,
                          );
                        }).toList(),
                      ),

                      SizedBox(height: 45),

                      Row(
                        children: [
                          Text(
                            'Photo',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),

                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(2, 2),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Color(0xFF0A4FD6),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.business.picture.map((pictures) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: PictureItems(
                                image: pictures.image,
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullImageScreen(
                                        image: pictures.image,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 45),

                      Row(
                        children: [
                          Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),

                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(2, 2),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              setState(() {
                                showAllReviews = !showAllReviews;
                              });
                            },
                            child: showAllReviews
                                ? Text(
                                    'See Less',
                                    style: TextStyle(
                                      color: Color(0xFF0A4FD6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Color(0xFF0A4FD6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.business.rating!,
                                style: TextStyle(fontSize: 28),
                              ),

                              SizedBox(height: 6),

                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),

                              SizedBox(height: 6),

                              Text(
                                '(${widget.business.reviewsCount} Rewies)',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: Column(
                              children: [
                                ratingRow(
                                  star: 5,
                                  value: widget.business.fiveStar!,
                                  total: widget.business.reviewsCount!,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 4,
                                  value: widget.business.fourStar!,
                                  total: widget.business.reviewsCount!,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 3,
                                  value: widget.business.threeStar!,
                                  total: widget.business.reviewsCount!,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 2,
                                  value: widget.business.twoStar!,
                                  total: widget.business.reviewsCount!,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 1,
                                  value: widget.business.oneStar!,
                                  total: widget.business.reviewsCount!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      showAllReviews
                          ? reviewCard(
                              text:
                                  'Great food, amazing emvironment and excellent customer service. Definitely coming back!',
                            )
                          : SizedBox(),

                      SizedBox(height: 10),

                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF0A4FD6),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_outline,
                                color: Colors.white,
                                size: 26,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Save Place',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
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

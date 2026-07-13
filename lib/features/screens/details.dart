import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/screens/full_image.dart';
import 'package:locafy/features/services/image_picker.dart';
import 'package:locafy/helper/app_snackbar.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/widgets/details_section/comment_section.dart';
import 'package:locafy/widgets/details_section/enquiry_items.dart';
import 'package:locafy/widgets/details_section/features_items.dart';
import 'package:locafy/widgets/details_section/picture_items.dart';
import 'dart:io';
import 'package:locafy/widgets/details_section/review_section.dart';
import 'package:locafy/features/services/cloudinary_sevice.dart';

class DetailsScreen extends StatefulWidget {
  final BusinessModel business;
  final String? distanceText;
  const DetailsScreen({
    super.key,
    required this.business,
    required this.distanceText,
  });
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedRating = 0;
  List<File?> selectedImages = List.filled(3, null);
  final reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  bool showAllComment = false;
  bool showReview = false;
  bool isSubmitting = false;
  final pickImages = ImagePickerService();
  final cloudinaryService = CloudinarySevice();

  Future<void> pickImage(int index) async {
    final picked = await pickImages.pickImage();
    if (picked == null) return;
    setState(() {
      selectedImages[index] = picked;
    });
  }

  void removePicked(int index) {
    setState(() {
      selectedImages[index] = null;
    });
  }

  void changeRating(int index) {
    setState(() {
      selectedRating = index + 1;
    });
  }

  Future<bool> submitReview() async {
    try {
      if (selectedRating == 0) {
        AppSnackBar.error(context, 'Please select a rating.');
        return false;
      }
      final comment = reviewController.text.trim();
      final imageUrls = <String>[];

      if (comment.isEmpty) {
        AppSnackBar.error(context, 'Please Leave  comment.');
        return false;
      }
      for (final image in selectedImages) {
        if (image != null) {
          final url = await cloudinaryService.uploadToCloudinary(image);

          imageUrls.add(url);
        }
      }
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();
      final username = userDoc["username"];
      // final userPhoto = userDoc["profileImage"];

      await FirebaseFirestore.instance
          .collection("businesses")
          .doc(widget.business.id)
          .collection("reviews")
          .add({
            "userId": uid,
            "userName": username,
            // "userPhoto": userPhoto,
            "comment": comment,
            "rating": selectedRating,
            "images": imageUrls,
            "helpfulCount": 0,
            "helpfulBy": [],
            "createdAt": FieldValue.serverTimestamp(),
          });
      if (!mounted) return false;
      setState(() {
        reviewController.clear();
        selectedRating = 0;
        selectedImages = List.filled(3, null);
        showReview = false;
        isSubmitting = false;
      });
      return true;
    } catch (e) {
      AppSnackBar.error(context, 'Failed to submit review. \n$e');
    }
    return false;
  }

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
                image: widget.business.image.startsWith('http')
                    ? NetworkImage(widget.business.image)
                    : AssetImage(widget.business.image) as ImageProvider,
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
            maxChildSize: 0.88,
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
                            widget.business.distanc ??
                                widget.distanceText ??
                                '',
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
                            "${widget.business.rating ?? ''} (${widget.business.reviewsCount ?? ''} reviews)",
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
                            'Open Now',
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
                                  widget.business.address ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 5),

                                Text(
                                  widget.business.distanc ??
                                      widget.distanceText ??
                                      '${widget.business.distance}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
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
                              widget.business.openingHours ??
                                  widget.business.distanc ??
                                  '',
                              style: TextStyle(fontSize: 16),
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
                            print(pictures.image);

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
                                showAllComment = !showAllComment;
                              });
                            },
                            child: showAllComment
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
                                '(${widget.business.reviewsCount ?? ''} Reviews)',
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
                                  value: widget.business.fiveStar ?? 0,
                                  total: widget.business.reviewsCount ?? 0,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 4,
                                  value: widget.business.fourStar ?? 0,
                                  total: widget.business.reviewsCount ?? 0,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 3,
                                  value: widget.business.threeStar ?? 0,
                                  total: widget.business.reviewsCount ?? 0,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 2,
                                  value: widget.business.twoStar ?? 0,
                                  total: widget.business.reviewsCount ?? 0,
                                ),

                                const SizedBox(height: 8),

                                ratingRow(
                                  star: 1,
                                  value: widget.business.oneStar ?? 0,
                                  total: widget.business.reviewsCount ?? 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      showReview
                          ? ReviewSection(
                              formKey: formKey,
                              controller: reviewController,
                              onPickImage: pickImage,
                              onRemoveImage: removePicked,
                              selectedRating: selectedRating,
                              onRatingChanged: (rating) {
                                setState(() {
                                  selectedRating = rating;
                                });
                              },
                              selectedImages: selectedImages,
                            )
                          : SizedBox(),
                      SizedBox(height: 20),

                      GestureDetector(
                        onTap: () async {
                          if (!showReview) {
                            setState(() {
                              showReview = true;
                            });
                            return;
                          }
                          if (isSubmitting) {
                            return;
                          }

                          setState(() {
                            isSubmitting = true;
                          });

                          final success = await submitReview();
                          if (!mounted) return;
                          if (success) {
                            AppSnackBar.success(
                              context,
                              "Review submitted successfully!",
                            );
                          }

                          setState(() {
                            isSubmitting = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: showReview == true
                                ? isSubmitting
                                      ? Colors.grey.withValues(alpha: 0.3)
                                      : Color(0xFF0A4FD6)
                                : Colors.grey.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: isSubmitting
                              ? Center(
                                  child: const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      style: TextStyle(color: Colors.white),
                                      showReview
                                          ? "Submit Review"
                                          : "Write a Review",
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: 15),

                      showAllComment
                          ? CommentSection(business: widget.business)
                          : SizedBox(),

                      SizedBox(height: 15),

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

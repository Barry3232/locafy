import 'package:flutter/material.dart';
import 'package:locafy/widgets/publish_section/add_picture.dart';
import 'dart:io';

class ReviewSection extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onRatingChanged;
  final ValueChanged<int> onPickImage;
  final ValueChanged<int> onRemoveImage;
  final TextEditingController controller;
  final List<File?> selectedImages;

  const ReviewSection({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.selectedRating,
    required this.onRatingChanged,
    required this.selectedImages,
  });

  final GlobalKey<FormState> formKey;

  Widget starButton(int index) {
    return IconButton(
      onPressed: () {
        onRatingChanged(index + 1);
      },
      icon: Icon(
        index < selectedRating ? Icons.star : Icons.star_border,
        color: index < selectedRating ? Colors.amber : Colors.grey,
        size: 37,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.5), blurRadius: 5),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Rate this Place',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => starButton(index)),
          ),

          SizedBox(height: 15),

          Text(
            'Leave a Comment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              maxLines: 4,
              autocorrect: true,
              maxLength: 500,
              onChanged: (value) {
                // Handle comment input change
              },
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Share your experience with others...',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Add Photos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              Text(
                '(Optional)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 10),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              selectedImages.length,
              (index) => PublisherPhoto(
                height: 100,
                width: 100,
                text: 'Add Photo',
                image: selectedImages[index],
                onTap: () => onPickImage(index),
                onRemove: () => onRemoveImage(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

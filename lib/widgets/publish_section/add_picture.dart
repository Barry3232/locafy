import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PublisherPhoto extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final String text;
  final double height;
  final double width;

  const PublisherPhoto({
    super.key,
    this.image,
    required this.height,
    required this.width,
    required this.text,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return image == null
        ? GestureDetector(
            onTap: onTap,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(15),
                dashPattern: [8, 4],
                strokeWidth: 2,
                color: Colors.grey,
              ),
              child: Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined),
                    SizedBox(height: 10),
                    Text(text),
                  ],
                ),
              ),
            ),
          )
        : Stack(
            children: [
              Container(
                height: height,
                width: width,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.file(image!, fit: BoxFit.cover),
              ),

              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: onRemove,

                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          );
  }
}

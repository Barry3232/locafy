import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PublisherPhoto extends StatelessWidget {
  const PublisherPhoto({super.key});

  final uploadPicture = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(15),
          dashPattern: [8, 4],
          strokeWidth: 2,
          padding: EdgeInsets.all(16),
          color: Colors.grey,
        ),
        child: Container(
          height: 85,
          width: 85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo_outlined),
              SizedBox(height: 10),
              Text("Add photo"),
            ],
          ),
        ),
      ),
    );
  }
}

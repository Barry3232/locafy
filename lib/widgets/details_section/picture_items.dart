import 'package:flutter/material.dart';

class PictureItems extends StatelessWidget {
  final VoidCallback ontap;
  final String image;
  const PictureItems({super.key, required this.image, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 190,
        width: 130,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: image.startsWith('http')
              ? Image.network(image, fit: BoxFit.cover)
              : Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

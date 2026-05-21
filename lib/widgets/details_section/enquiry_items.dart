import 'package:flutter/material.dart';

class EnquiryItems extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const EnquiryItems({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          shape: CircleBorder(),
          color: Colors.transparent,

          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onTap,
            child: CircleAvatar(
              radius: 27,
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Icon(icon, color: Color(0xFF0A4FD6), size: 28),
            ),
          ),
        ),
        SizedBox(height: 7),
        Text(text),
      ],
    );
  }
}

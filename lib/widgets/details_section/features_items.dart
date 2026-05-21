import 'package:flutter/material.dart';

class FeaturesItems extends StatelessWidget {
  final String name;
  final IconData icon;
  const FeaturesItems({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF0A4FD6), size: 15),

            SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

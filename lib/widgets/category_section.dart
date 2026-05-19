import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? iconColor;

  const CategoryItems({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,

    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: color,
                child: Icon(icon, size: 20, color: iconColor),
              ),
            ),
            SizedBox(width: 10),
            Center(child: Text(title, style: TextStyle(fontSize: 11))),
          ],
        ),
      ),
    );
  }
}

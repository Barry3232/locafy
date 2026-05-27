import 'package:flutter/material.dart';

class FeaturesAmenities extends StatefulWidget {
  final String name;
  final IconData icon;

  const FeaturesAmenities({super.key, required this.name, required this.icon});

  @override
  State<FeaturesAmenities> createState() => _FeaturesAmenitiesState();
}

class _FeaturesAmenitiesState extends State<FeaturesAmenities> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.black12),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Icon(widget.icon, color: const Color(0xFF0A4FD6), size: 14),

          const SizedBox(width: 6),

          Text(
            widget.name,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),

          Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: _isSelected,

              visualDensity: VisualDensity.compact,

              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

              onChanged: (value) {
                setState(() {
                  _isSelected = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

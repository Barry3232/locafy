import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  final String image;
  const FullImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              child: image.startsWith('http')
                  ? Image.network(image, fit: BoxFit.cover)
                  : Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

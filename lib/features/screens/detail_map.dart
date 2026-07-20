import 'package:flutter/material.dart';

class DirectionScreen extends StatelessWidget {
  const DirectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// MAP PLACEHOLDER
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.map, size: 100, color: Colors.white),
            ),
          ),

          /// BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),

          /// MY LOCATION BUTTON
          Positioned(
            right: 16,
            bottom: 220,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.my_location, color: Colors.blue),
              ),
            ),
          ),

          /// BOTTOM CARD
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 210,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Barry Restaurant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "8 mins • 2.4 km",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  const Divider(height: 30),

                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text("8b Trans Woji Road, Port Harcourt"),
                      ),
                    ],
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},

                      icon: const Icon(Icons.navigation),

                      label: const Text("Start Navigation"),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A4FD6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

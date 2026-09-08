import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/features/screens/details.dart';
import 'package:locafy/widgets/home_section/porpular_grid_items.dart';

class PopularBusinessesScreen extends StatefulWidget {
  final List<BusinessModel> businesses;

  const PopularBusinessesScreen({super.key, required this.businesses});

  @override
  State<PopularBusinessesScreen> createState() =>
      _PopularBusinessesScreenState();
}

class _PopularBusinessesScreenState extends State<PopularBusinessesScreen> {
  Position? userPosition;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        userPosition = position;
      });
    }
    print('USER LAT: ${position.latitude}');
    print('USER LNG: ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Popular Businesses",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0A4FD6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.businesses.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 per row

            crossAxisSpacing: 12, // horizontal spacing

            mainAxisSpacing: 12, // vertical spacing

            childAspectRatio: 0.75,
          ),

          itemBuilder: (context, index) {
            final business = widget.businesses[index];
            final distanceText = business.getFormattedDistance(userPosition);

            return PopularGridItem(
              business: business,
              distanceText: business.distanc ?? distanceText,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(
                      business: business,
                      distanceText: business.distanc ?? distanceText,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
      
//       ListView.builder(

//         itemCount: businesses.length,
//         itemBuilder: (context, index) {
//           final business = businesses[index];

//           return PopularItems(
//             business: business,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => DetailsScreen(business: business),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
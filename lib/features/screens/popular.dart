import 'package:flutter/material.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/features/screens/details.dart';
import 'package:locafy/widgets/home_section/porpular_grid_items.dart';

class PopularBusinessesScreen extends StatelessWidget {
  final List<BusinessModel> businesses;

  const PopularBusinessesScreen({super.key, required this.businesses});

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
          itemCount: businesses.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 per row

            crossAxisSpacing: 12, // horizontal spacing

            mainAxisSpacing: 12, // vertical spacing

            childAspectRatio: 0.75,
          ),

          itemBuilder: (context, index) {
            final business = businesses[index];

            return PopularGridItem(
              business: business,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(business: business),
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
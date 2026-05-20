import 'package:flutter/material.dart';
import 'package:locafy/data/dummy_data.dart';
import 'package:locafy/features/screens/details.dart';
import 'package:locafy/widgets/category_section.dart';
import 'package:locafy/widgets/porpular_section.dart';
import 'package:locafy/widgets/recommended_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          toolbarHeight: 120,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0A4FD6),

          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text(
                    'LOCAFY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                ],
              ),
              SizedBox(height: 8),

              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search places, categories...',
                  prefixIcon: const Icon(Icons.search, size: 25),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 25),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,

                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/explore.jpg',
                        height: 230,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Container(
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Text(
                              'Explore Your City Like Never Before',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          SizedBox(
                            width: 200,
                            child: Text(
                              'Find amazing places, connect local and experience more.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.3,
                              ),
                            ),
                          ),

                          SizedBox(height: 15),

                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Color(0xFF0A4FD6),
                              ),
                              shape:
                                  WidgetStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Explore Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF0A4FD6)),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryItems(
                    title: 'Restaurants',
                    icon: Icons.restaurant_outlined,
                    color: Color(0x14FF9800),
                    iconColor: Color(0xFFFF9800),
                    onTap: () {},
                  ),
                  CategoryItems(
                    title: 'Hotels',
                    icon: Icons.hotel_outlined,
                    color: Color(0x1400B0FF),
                    iconColor: Color(0xFF00B0FF),
                    onTap: () {},
                  ),
                  CategoryItems(
                    title: 'Shops',
                    icon: Icons.shopping_bag_outlined,
                    color: Color(0x1400C853),
                    iconColor: Color(0xFF00C853),
                    onTap: () {},
                  ),
                  CategoryItems(
                    title: 'Services',
                    icon: Icons.handyman_outlined,
                    color: Color(0x14FF4081),
                    iconColor: Color(0xFFFF4081),
                    onTap: () {},
                  ),
                  CategoryItems(
                    title: 'More',
                    icon: Icons.grid_view_outlined,
                    color: Color(0x14000000),
                    iconColor: Color(0xFF000000),
                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Text(
                    'Popular Near You',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF0A4FD6)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    PopularItems(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen(business: businesses[0]);
                            },
                          ),
                        );
                        // Handle tap event, e.g., navigate to details page
                      },
                      business: businesses[0],
                    ),

                    SizedBox(width: 15),

                    PopularItems(
                      onTap: () {
                        // Handle tap event, e.g., navigate to details page
                      },
                      business: businesses[1],
                    ),

                    SizedBox(width: 15),

                    PopularItems(
                      onTap: () {
                        // Handle tap event, e.g., navigate to details page
                      },
                      business: businesses[2],
                    ),

                    SizedBox(width: 15),

                    PopularItems(
                      onTap: () {
                        // Handle tap event, e.g., navigate to details page
                      },
                      business: businesses[3],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Recommended for You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              RecommendedItems(
                onTap: () {
                  // Handle tap event, e.g., navigate to details page
                },
                business: businesses[4],
              ),

              SizedBox(height: 15),

              RecommendedItems(
                onTap: () {
                  // Handle tap event, e.g., navigate to details page
                },
                business: businesses[5],
              ),

              SizedBox(height: 15),

              RecommendedItems(
                onTap: () {
                  // Handle tap event, e.g., navigate to details page
                },
                business: businesses[6],
              ),

              SizedBox(height: 15),

              RecommendedItems(
                onTap: () {
                  // Handle tap event, e.g., navigate to details page
                },
                business: businesses[7],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:locafy/widgets/publish_section/add_picture.dart';
import 'package:locafy/widgets/publish_section/features_amenities.dart';

class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  String? selectedCategory;
  String? selectedBusinessType;
  String? selectedTime;

  final List<String> categories = [
    'Restaurant',
    'Shop',
    'Resort',
    'Hotel',
    'Cafe',
    'Gym',
    'Salon',
  ];

  final List<String> businessTypes = [
    'Small Business',
    'Enterprise',
    'Online Business',
    'Local Brand',
    'Franchise',
  ];

  final List<String> time = [
    '8am - 5pm',
    '9am - 6pm',
    '10am - 7pm',
    '11am - 8pm',
    '12pm - 9pm',
    '24/7',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Create Business',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Add your business details',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Business Photos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                'Add photos of your business (max 5)',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),

                child: Row(
                  children: [
                    PublisherPhoto(),
                    SizedBox(width: 10),
                    PublisherPhoto(),
                    SizedBox(width: 10),
                    PublisherPhoto(),
                    SizedBox(width: 10),
                    PublisherPhoto(),
                    SizedBox(width: 10),
                    PublisherPhoto(),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Business Name *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),

              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your business name',
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0A4FD6), width: 2),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category *',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3,
                          menuMaxHeight: 200,
                          initialValue: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.grid_view_outlined),

                            hintText: 'Category',
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF0A4FD6),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Type *',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 10),

                        DropdownButtonFormField(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3,
                          menuMaxHeight: 200,
                          initialValue: selectedBusinessType,
                          items: businessTypes.map((business) {
                            return DropdownMenuItem(
                              value: business,
                              child: Text(
                                business,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBusinessType = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.business_center_outlined),

                            hintText: 'Business',
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF0A4FD6),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                'Description *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(fontSize: 14),
                minLines: 5,
                maxLines: 6,
                maxLength: 330,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'Tell us about your business',
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0A4FD6), width: 2),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Phone Number *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 11,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  counterText: '',
                  prefixIcon: Icon(Icons.phone_outlined, size: 25),
                  hintText: 'Enter phone number',
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0A4FD6), width: 2),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Business Location *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined),
                  suffixIcon: Icon(Icons.navigate_next_outlined),
                  hintText: 'Select on map',
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0A4FD6), width: 2),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Opening Hours *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 10),

              DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10),
                icon: Icon(Icons.keyboard_arrow_down),
                elevation: 3,
                menuMaxHeight: 200,
                dropdownColor: Colors.white,
                items: time.map((items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTime = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.access_time),

                  hintText: 'Set opening hours',
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0A4FD6), width: 2),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Features & Amenities *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 1),
              Text(
                'Select all that apply',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 10),

              Wrap(
                spacing: 5,
                runSpacing: 13,
                children: [
                  FeaturesAmenities(name: 'Wi-Fi', icon: Icons.wifi),
                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Parking',
                    icon: Icons.local_parking_outlined,
                  ),

                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Delivery',
                    icon: Icons.delivery_dining_outlined,
                  ),

                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Reservations',
                    icon: Icons.event_seat_outlined,
                  ),

                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Pet Friendly',
                    icon: Icons.pets_outlined,
                  ),

                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Takeaway',
                    icon: Icons.shopping_bag_outlined,
                  ),
                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Wheelchair Accessible',
                    icon: Icons.accessible_outlined,
                  ),
                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Outdoor Seating',
                    icon: Icons.deck_outlined,
                  ),

                  SizedBox(width: 5),
                  FeaturesAmenities(
                    name: 'Air Conditioning',
                    icon: Icons.ac_unit_outlined,
                  ),
                ],
              ),

              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Handle publish action
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFF0A4FD6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Publish Business',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'By publishing, you agree to our Terms of Service and Privacy Policy.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

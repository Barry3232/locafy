import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/screens/nav_bar.dart';
import 'package:locafy/widgets/publish_section/add_picture.dart';
import 'package:locafy/widgets/publish_section/features_amenities.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:locafy/widgets/publish_section/map_section.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:locafy/widgets/publish_section/on_success.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  String? selectedCategory;
  String? selectedBusinessType;
  String? selectedTime;
  File? coverPhoto;
  String? selectedAddress;
  double? selectedLatitude;
  double? selectedLongitude;
  bool isSelected = false;
  bool _isLoading = false;
  bool _isSuccess = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode locationFocusNode = FocusNode();

  Future<void> imagePicker(int index) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final image = ImagePicker();
      final picked = await image.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        selectedImages[index] = File(picked.path);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print("Error picking image: $e");
    }
  }

  Future<String> uploadToCloudinary(File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/ddd16s54h/image/upload'),
    );

    request.fields['upload_preset'] = 'locafy_business';

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    final data = jsonDecode(responseData);

    return data['secure_url'];
  }

  // Future<String> uploadCoverPhoto(String businessId, File imageFile) async {
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('businesses')}
  //       .child(businessId)
  //       .child('cover.jpg');

  //   await ref.putFile(imageFile);

  //   return await ref.getDownloadURL();
  // }

  Future<List<String>> uploadBusinessImages() async {
    List<String> urls = [];

    for (final image in selectedImages) {
      if (image == null) continue;

      final url = await uploadToCloudinary(image);

      urls.add(url);
    }

    return urls;
  }

  // Future<List<String>> uploadBusinessImages(String businessId) async {
  //   List<String> imageUrls = [];

  //   for (int i = 0; i < selectedImages.length; i++) {
  //     final image = selectedImages[i];

  //     if (image == null) continue;

  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('businesses')
  //         .child(businessId)
  //         .child('image_$i.jpg');

  //     await ref.putFile(image);

  //     final url = await ref.getDownloadURL();

  //     imageUrls.add(url);
  //   }

  //   return imageUrls;
  // }

  List<String> selectedAmenities = [];

  final amenities = [
    ('Wi-Fi', Icons.wifi),
    ('Parking', Icons.local_parking_outlined),
    ('Delivery', Icons.delivery_dining_outlined),
    ('Reservations', Icons.event_seat_outlined),
    ('Pet Friendly', Icons.pets_outlined),
    ('Takeaway', Icons.shopping_bag_outlined),
    ('Wheelchair Accessible', Icons.accessible_outlined),
    ('Outdoor Seating', Icons.deck_outlined),
    ('Air Conditioning', Icons.ac_unit_outlined),
  ];
  List<File?> selectedImages = [null, null, null, null, null];

  Future<void> pickCoverPhoto() async {
    final image = ImagePicker();

    final picked = await image.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;

    setState(() {
      coverPhoto = File(picked.path);
    });
  }

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
  void initState() {
    super.initState();

    locationFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    locationFocusNode.dispose();
    super.dispose();
  }

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

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 120),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Business Cover Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),

                    PublisherPhoto(
                      height: 180,
                      width: double.infinity,
                      text: "Add cover photo",
                      image: coverPhoto,
                      onTap: () => pickCoverPhoto(),
                      onRemove: () {
                        setState(() {
                          coverPhoto = null;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Business Photos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
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
                          PublisherPhoto(
                            height: 85,
                            width: 85,
                            text: "Add photo",
                            image: selectedImages[0],
                            onTap: () => imagePicker(0),
                            onRemove: () {
                              setState(() {
                                selectedImages[0] = null;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          PublisherPhoto(
                            height: 85,
                            width: 85,
                            text: "Add photo",
                            image: selectedImages[1],
                            onTap: () => imagePicker(1),
                            onRemove: () {
                              setState(() {
                                selectedImages[1] = null;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          PublisherPhoto(
                            height: 85,
                            width: 85,
                            text: "Add photo",
                            image: selectedImages[2],
                            onTap: () => imagePicker(2),
                            onRemove: () {
                              setState(() {
                                selectedImages[2] = null;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          PublisherPhoto(
                            height: 85,
                            width: 85,
                            text: "Add photo",
                            image: selectedImages[3],
                            onTap: () => imagePicker(3),
                            onRemove: () {
                              setState(() {
                                selectedImages[3] = null;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          PublisherPhoto(
                            height: 85,
                            width: 85,
                            text: "Add photo",
                            image: selectedImages[4],
                            onTap: () => imagePicker(4),
                            onRemove: () {
                              setState(() {
                                selectedImages[4] = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Business Name *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Business name is required";
                        }
                        return null;
                      },
                      controller: _businessNameController,
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
                          borderSide: BorderSide(
                            color: Color(0xFF0A4FD6),
                            width: 2,
                          ),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a category";
                                  }
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a business type";
                                  }
                                  return null;
                                },
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
                                  prefixIcon: Icon(
                                    Icons.business_center_outlined,
                                  ),

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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Description is required";
                        }
                        if (value.length < 50) {
                          return "Description must be at least 50 characters";
                        }
                        return null;
                      },
                      controller: _descriptionController,
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
                          borderSide: BorderSide(
                            color: Color(0xFF0A4FD6),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Phone Number *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required";
                        }
                        if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
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
                          borderSide: BorderSide(
                            color: Color(0xFF0A4FD6),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Business Location *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Focus(
                      focusNode: locationFocusNode,
                      child: GestureDetector(
                        onTap: () async {
                          locationFocusNode.requestFocus();
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapSection(
                                initialLatitude: selectedLatitude,
                                initialLongitude: selectedLongitude,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              selectedAddress = result["address"];
                              selectedLatitude = result["latitude"];
                              selectedLongitude = result["longitude"];
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: locationFocusNode.hasFocus
                                  ? const Color(0xFF0A4FD6)
                                  : Colors.grey,
                              width: locationFocusNode.hasFocus ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  selectedAddress ?? "Select on map",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const Icon(Icons.navigate_next_outlined),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Opening Hours *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      icon: Icon(Icons.keyboard_arrow_down),
                      elevation: 3,
                      menuMaxHeight: 200,
                      dropdownColor: Colors.white,
                      items: time.map((items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
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
                          borderSide: BorderSide(
                            color: Color(0xFF0A4FD6),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Features & Amenities *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Select all that apply',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(height: 10),

                    Wrap(
                      spacing: 10,
                      runSpacing: 13,
                      children: amenities.map((amenity) {
                        final name = amenity.$1;
                        final icon = amenity.$2;

                        return FeaturesAmenities(
                          name: name,
                          icon: icon,
                          isSelected: selectedAmenities.contains(name),
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                selectedAmenities.add(name);
                              } else {
                                selectedAmenities.remove(name);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 30),
                    InkWell(
                      onTap: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          if (coverPhoto == null) {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please add a cover photo"),
                              ),
                            );
                            return;
                          }

                          if (selectedImages.every((image) => image == null)) {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please add at least one business photo",
                                ),
                              ),
                            );
                            return;
                          }

                          if (selectedAmenities.isEmpty) {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Select at least one amenity"),
                              ),
                            );
                            return;
                          }

                          final docRef = FirebaseFirestore.instance
                              .collection('businesses')
                              .doc();

                          final businessId = docRef.id;
                          final coverPhotoUrl = await uploadToCloudinary(
                            coverPhoto!,
                          );

                          final galleryUrls = await uploadBusinessImages();
                          final currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please login first"),
                              ),
                            );

                            setState(() {
                              _isLoading = false;
                            });

                            return;
                          }

                          await docRef.set({
                            'id': businessId,
                            'ownerId': currentUser.uid,
                            'businessName': _businessNameController.text.trim(),
                            'category': selectedCategory,
                            'businessType': selectedBusinessType,
                            'description': _descriptionController.text.trim(),
                            'phoneNumber': _phoneNumberController.text.trim(),

                            'address': selectedAddress,
                            'latitude': selectedLatitude,
                            'longitude': selectedLongitude,

                            'openingHours': selectedTime,

                            'amenities': selectedAmenities,

                            'coverPhotoUrl': coverPhotoUrl,

                            'businessImages': galleryUrls,

                            'createdAt': FieldValue.serverTimestamp(),
                          });

                          setState(() {
                            _isSuccess = true;
                          });

                          await Future.delayed(const Duration(seconds: 3));

                          if (!mounted) return;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => NavBarScreen()),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Unable to publish business'),
                            ),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : Color(0xFF0A4FD6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircleAvatar(
                                  radius: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
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

                if (_isSuccess)
                  OnSuccess(name: 'Business published Successfully'),
                Center(
                  child: Container(
                    color: Colors.black54,
                    child: Center(
                      child: Container(
                        width: 260,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 70,
                            ),

                            SizedBox(height: 15),

                            Text(
                              'Publish Successfully',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

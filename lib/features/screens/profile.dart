import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Uint8List? _profileImageBytes;
  Map<String, dynamic>? user;
  bool _isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    if (currentUser == null) {
      debugPrint('❌ No authenticated user');
      setState(() {
        _isLoadingUser = false;
      });
      return;
    }

    debugPrint('✅ Current user UID: ${currentUser!.uid}');

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      debugPrint('📄 Document exists: ${doc.exists}');
      debugPrint('📄 Document ID: ${doc.id}');
      debugPrint('📄 Document data: ${doc.data()}');

      if (!doc.exists) {
        debugPrint('❌ No user document found for this UID');

        setState(() {
          _isLoadingUser = false;
        });

        return;
      }

      final data = doc.data();

      debugPrint('👤 User data: $data');
      debugPrint('First name: ${data?['firstName']}');
      debugPrint('Last name: ${data?['lastName']}');
      debugPrint('Username: ${data?['username']}');

      if (data != null && data['profileImage'] != null) {
        _profileImageBytes = base64Decode(data['profileImage']);
      }

      setState(() {
        user = data;
        _isLoadingUser = false;
      });

      debugPrint('✅ User data loaded successfully');
    } catch (e) {
      debugPrint('❌ Error getting user data: $e');

      setState(() {
        _isLoadingUser = false;
      });
    }
  }

  Future<void> _pickProfileImage() async {
    if (currentUser == null) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;
    final File imageFile = File(pickedImage.path);
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({'profileImage': base64Image});

      setState(() {
        _profileImageBytes = bytes;
      });
    } catch (e) {
      debugPrint('Error updating profile image: $e');
    }
  }

  Widget profileStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A4FD6),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // Handle settings action
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 120),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF0A4FD6),
                      borderRadius: BorderRadius.circular(20),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            4,
                          ), // changes position of shadow
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            color: Color(0xFF0A4FD6),

                            child: Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: _pickProfileImage,
                                    child: CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.blueGrey,
                                      backgroundImage:
                                          _profileImageBytes != null
                                          ? MemoryImage(_profileImageBytes!)
                                          : null,
                                      child: _profileImageBytes == null
                                          ? const Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 13),
                                      Text(
                                        _isLoadingUser
                                            ? 'Loading...'
                                            : '${user?['lastName'] ?? ''} ${user?['firstName'] ?? ''}'
                                                  .trim(),
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        _isLoadingUser
                                            ? '@loading...'
                                            : '@${user?['username'] ?? 'username'}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 4),

                                      SizedBox(height: 10),

                                      Container(
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.workspace_premium,
                                              size: 16,
                                              color: Colors.yellowAccent,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'Premium Member',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            height: 90,
                            width: double.infinity,
                            color: Colors.white,

                            child: Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: () {
                                            // HANDLE SAVED
                                          },
                                          child: profileStat('18', 'Saved'),
                                        ),
                                      ),

                                      Container(
                                        height: 40,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),

                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: () {
                                            //HANDLE REVIEWS
                                          },
                                          child: profileStat('5', 'Reviews'),
                                        ),
                                      ),

                                      Container(
                                        height: 40,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),

                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: () {
                                            //HANDLE CHECK-INS
                                          },
                                          child: profileStat('12', 'Check-Ins'),
                                        ),
                                      ),

                                      Container(
                                        height: 40,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),

                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: () {
                                            //HANDLE Following
                                          },
                                          child: profileStat('24', 'Following'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE SAVED PLACES
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.bookmark_outline),
                              title: Text('Saved Places'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 1,
                          indent: 20,
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE MY REVIEWS
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.star_border_outlined),
                              title: Text('My Reviews'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 1,
                          indent: 20,
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE CHECK-IN HISTORY
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.location_on_outlined),
                              title: Text('Check-in History'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1.2,
                          height: 1,
                          indent: 20,
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE FOLLOWING
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.person_2_outlined),
                              title: Text('Following'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE SETTINGS
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.settings_outlined),
                              title: Text('Settings'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 1,
                          indent: 20,
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE PRIVACY POLICY
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.privacy_tip_outlined),
                              title: Text('Privacy Policy'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 1,
                          indent: 20,
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE HELP & SUPPORT
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.help_outline),
                              title: Text('Help & Support'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),

                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 1,
                          indent: 20,
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE ABOUT LOCAFY
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(Icons.info_outline),
                              title: Text('About Locafy'),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              //HANDLE LOG OUT
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              leading: Icon(
                                Icons.logout_outlined,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Log Out',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locafy/models/business_model.dart';

class DetailsScreen extends StatelessWidget {
  final BusinessModel business;
  const DetailsScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(business.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    Spacer(),

                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              DraggableScrollableSheet(
                initialChildSize: 0.57,
                minChildSize: 0.57,
                maxChildSize: 0.95,
                builder: (context, ScrollController) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: ScrollController,
                      child: Column(children: []),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

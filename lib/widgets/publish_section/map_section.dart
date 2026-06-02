import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapSection extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  const MapSection({super.key, this.initialLatitude, this.initialLongitude});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  TextEditingController searchController = TextEditingController();

  String selectedAddress = 'Loading location....';
  String selectedStreet = '';
  String selectedLocalityCountry = '';
  final MapController mapController = MapController();
  LatLng selectedLocation = const LatLng(4.8156, 7.0498);
  @override
  void initState() {
    super.initState();

    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      selectedLocation = LatLng(
        widget.initialLatitude!,
        widget.initialLongitude!,
      );

      getAddress(widget.initialLatitude!, widget.initialLongitude!);
    } else {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    selectedLocation = LatLng(position.latitude, position.longitude);

    await getAddress(position.latitude, position.longitude);

    setState(() {});
  }

  Future<void> searchLocation() async {
    try {
      final locations = await locationFromAddress(searchController.text.trim());
      final location = locations.first;

      mapController.move(LatLng(location.latitude, location.longitude), 16);

      selectedLocation = LatLng(location.latitude, location.longitude);

      await getAddress(location.latitude, location.longitude);

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Location not found")));
    }
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        setState(() {
          selectedStreet = place.street ?? '';
          selectedLocalityCountry =
              "${place.locality ?? ''}, ${place.country ?? ''}";
          selectedAddress =
              "${place.street}, "
              "${place.locality}, "
              "${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        selectedAddress = "Address unavailable";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: selectedLocation,
              initialZoom: 16,
              onPositionChanged: (position, hasGesture) {
                selectedLocation = position.center;
              },
              onTap: (tapPosition, point) async {
                selectedLocation = point;
                await getAddress(point.latitude, point.longitude);
                setState(() {});
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.locafy',
              ),
            ],
          ),

          const Center(
            child: Icon(Icons.location_pin, size: 50, color: Colors.red),
          ),

          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              height: 57,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  searchLocation();
                },
                decoration: InputDecoration(
                  hintText: "Search place",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 25),
                          onPressed: () {
                            searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,

                  border: InputBorder.none,

                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black12),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red.withOpacity(0.1),
                        child: Icon(
                          Icons.location_pin,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),

                      SizedBox(width: 10),

                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Selected Location",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              selectedStreet,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedLocalityCountry,
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Container(
                    height: 60,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Color(0xFF0A4FD6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.my_location, color: Color(0xFF0A4FD6)),
                          Column(
                            children: [
                              Text(
                                "Latitude",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(
                                selectedLocation.latitude.toStringAsFixed(4),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.blue.withOpacity(0.5),
                          ),
                          Column(
                            children: [
                              Text(
                                "Longitude",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(
                                selectedLocation.longitude.toStringAsFixed(4),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateOutlinedBorder.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        backgroundColor: WidgetStateColor.resolveWith(
                          (states) => Color(0xFF0A4FD6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, {
                          "address": selectedAddress,
                          "latitude": selectedLocation.latitude,
                          "longitude": selectedLocation.longitude,
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          const Text(
                            "Confirm Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
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

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  String selectedAddress = 'Loading location....';
  final MapController mapController = MapController();
  LatLng selectedLocation = const LatLng(4.8156, 7.0498);
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        setState(() {
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

              MarkerLayer(
                markers: [
                  Marker(
                    point: selectedLocation,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Center(
            child: Icon(Icons.location_pin, size: 50, color: Colors.red),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
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
                  const Text(
                    "Selected Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(selectedAddress),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          "address": selectedAddress,
                          "latitude": selectedLocation.latitude,
                          "longitude": selectedLocation.longitude,
                        });
                      },
                      child: const Text("Confirm Location"),
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

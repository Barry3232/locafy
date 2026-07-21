import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/features/services/route_service.dart';

class DirectionScreen extends StatefulWidget {
  final BusinessModel business;
  final String? distanceText;
  const DirectionScreen({
    super.key,
    required this.business,
    required this.distanceText,
  });

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  final MapController mapController = MapController();
  LatLng? currentLocation;
  List<LatLng> routePoints = [];
  double? routeDistance;
  double? routeDuration;
  bool loadingRoute = false;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();
    if (!mounted) return;
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    final bounds = LatLngBounds.fromPoints([
      currentLocation!,
      LatLng(widget.business.latitude!, widget.business.longitude!),
    ]);

    mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(80)),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    print('no');
    print(widget.business.latitude);
    print(widget.business.longitude);
    return Scaffold(
      body: Stack(
        children: [
          /// MAP PLACEHOLDER
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter:
                  currentLocation ??
                  LatLng(widget.business.latitude!, widget.business.longitude!),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.locafy',
              ),

              // navigation route polyline
              if (routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: 6,
                      color: const Color(0xFF0A4FD6),
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  /// USER LOCATION
                  if (currentLocation != null)
                    Marker(
                      point: currentLocation!,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),

                  /// BUSINESS LOCATION
                  Marker(
                    point: LatLng(
                      widget.business.latitude!,
                      widget.business.longitude!,
                    ),
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ],
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
            right: 15,
            bottom: 270,
            child: FloatingActionButton.small(
              heroTag: "location",
              backgroundColor: Colors.white,
              onPressed: () {
                if (currentLocation != null) {
                  mapController.move(currentLocation!, 16);
                }
              },
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
          ),

          /// BOTTOM CARD
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 240,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.business.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        routeDuration == null
                            ? "-- min"
                            : "${(routeDuration! / 60).round()} min",
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        routeDistance == null
                            ? widget.distanceText ?? "Distance unavailable"
                            : "${(routeDistance! / 1000).toStringAsFixed(1)} km",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),

                  const Divider(height: 30),

                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          widget.business.address ?? "No address available",
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        print('Start Navigation button pressed');
                        if (currentLocation == null) return;

                        final result = await RouteService().getRouteDetails(
                          start: currentLocation!,
                          end: LatLng(
                            widget.business.latitude!,
                            widget.business.longitude!,
                          ),
                        );

                        setState(() {
                          routePoints = result["points"];
                          routeDistance = result["distance"];
                          routeDuration = result["duration"];
                        });
                      },

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

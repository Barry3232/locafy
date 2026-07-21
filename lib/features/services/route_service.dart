import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

class RouteService {
  final Dio _dio = Dio();

  Future<List<LatLng>> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      print('NO');
      print("START: ${start.latitude}, ${start.longitude}");
      print("END: ${end.latitude}, ${end.longitude}");

      print(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}',
      );
      final response = await _dio.get(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}',
        queryParameters: {'overview': 'full', 'geometries': 'geojson'},
      );

      final coordinates =
          response.data['routes'][0]['geometry']['coordinates'] as List;

      return coordinates.map((point) {
        return LatLng(
          (point[1] as num).toDouble(), // latitude
          (point[0] as num).toDouble(), // longitude
        );
      }).toList();
    } on DioException catch (e) {
      print("Status Code: ${e.response?.statusCode}");
      print("Response:");
      print(e.response?.data);
      throw Exception("Failed to load route: $e");
    }
  }

  Future<Map<String, dynamic>> getRouteDetails({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final response = await _dio.get(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}',
        queryParameters: {'overview': 'full', 'geometries': 'geojson'},
      );

      final route = response.data['routes'][0];

      final coordinates = route['geometry']['coordinates'] as List;

      final points = coordinates.map((point) {
        return LatLng(
          (point[1] as num).toDouble(),
          (point[0] as num).toDouble(),
        );
      }).toList();

      return {
        "points": points,
        "distance": (route["distance"] as num).toDouble(), // metres
        "duration": (route["duration"] as num).toDouble(), // seconds
      };
    } on DioException catch (e) {
      print("Status Code: ${e.response?.statusCode}");
      print("Response:");
      print(e.response?.data);

      throw Exception("Failed to load route: $e");
    }
  }
}

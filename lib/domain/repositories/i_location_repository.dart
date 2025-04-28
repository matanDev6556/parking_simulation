import 'package:geolocator/geolocator.dart';

abstract class ILocationRepository {
  Future<bool> checkLocationPermission();
  Future<bool> requestLocationPermission();
  Future<Position?> getCurrentLocation();
}

import 'package:pumba_ex/data/services/location_servic.dart';
import 'package:pumba_ex/domain/repositories/i_location_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository implements ILocationRepository {
  final LocationService _locationService;

  LocationRepository({required LocationService locationService})
      : _locationService = locationService;

  @override
  Future<bool> checkLocationPermission() async {
    return await _locationService.checkLocationPermission();
  }

  @override
  Future<bool> requestLocationPermission() async {
    return await _locationService.requestLocationPermission();
  }

  @override
  Future<Position?> getCurrentLocation() async {
    return await _locationService.getCurrentLocation();
  }
}




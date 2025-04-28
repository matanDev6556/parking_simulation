import 'package:geolocator/geolocator.dart';
import 'package:pumba_ex/domain/repositories/i_location_repository.dart';

class CheckLocationPermissionUseCase {
  final ILocationRepository locationRepository;

  CheckLocationPermissionUseCase({required this.locationRepository});

  Future<bool> call() async {
    return await locationRepository.checkLocationPermission();
  }
}


class RequestLocationPermissionUseCase {
  final ILocationRepository locationRepository;

  RequestLocationPermissionUseCase({required this.locationRepository});

  Future<bool> call() async {
    return await locationRepository.requestLocationPermission();
  }
}

class GetCurrentLocationUseCase {
  final ILocationRepository locationRepository;

  GetCurrentLocationUseCase({required this.locationRepository});

  Future<Position?> call() async {
    return await locationRepository.getCurrentLocation();
  }
}
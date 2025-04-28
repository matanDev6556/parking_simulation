import 'package:geolocator/geolocator.dart';


enum LocationStatus { initial, loading, granted, denied }

class LocationState {
  final LocationStatus status;
  final Position? position;

  LocationState({required this.status, this.position});
}


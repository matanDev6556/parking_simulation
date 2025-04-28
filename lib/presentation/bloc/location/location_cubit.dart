import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/domain/usecases/location_usecases.dart';
import 'package:pumba_ex/presentation/bloc/location/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final CheckLocationPermissionUseCase checkLocationPermissionUseCase;
  final RequestLocationPermissionUseCase requestLocationPermissionUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  LocationCubit({
    required this.checkLocationPermissionUseCase,
    required this.requestLocationPermissionUseCase,
    required this.getCurrentLocationUseCase,
  }) : super(LocationState(status: LocationStatus.initial));

  Future<void> checkAndRequestLocation() async {
    emit(LocationState(status: LocationStatus.loading));

    try {
      bool hasPermission = await checkLocationPermissionUseCase();
      if (!hasPermission) {
        hasPermission = await requestLocationPermissionUseCase();
      }

      if (hasPermission) {
        final position = await getCurrentLocationUseCase();
        emit(LocationState(status: LocationStatus.granted, position: position));
      } else {
        emit(LocationState(status: LocationStatus.denied));
      }
    } catch (e) {
      emit(LocationState(status: LocationStatus.denied));
    }
  }
}

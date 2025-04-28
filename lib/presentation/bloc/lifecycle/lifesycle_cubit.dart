import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/domain/usecases/app_lifesycle_uscecases.dart';

enum LifecycleState { initial, monitoring, stopped }

class LifecycleCubit extends Cubit<LifecycleState> {
  final MonitorAppLifecycleUseCase _monitorUseCase;
  String? _currentUserId;

  LifecycleCubit(this._monitorUseCase) : super(LifecycleState.initial);

  void startMonitoring(String userId) async {
    _currentUserId = userId;
    await _monitorUseCase.startMonitoring(userId);
    emit(LifecycleState.monitoring);
  }

  void stopMonitoring() async {
    if (_currentUserId != null) {
      await _monitorUseCase.stopMonitoring(_currentUserId!);
      await _monitorUseCase.markOffline(_currentUserId!);
      emit(LifecycleState.stopped);
    }
  }

  void markOffline() async {
    if (_currentUserId != null) {
      await _monitorUseCase.markOffline(_currentUserId!);
    }
  }
}

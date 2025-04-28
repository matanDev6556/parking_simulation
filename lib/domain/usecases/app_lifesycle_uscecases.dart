import 'package:pumba_ex/domain/repositories/i_app_lifecycle_repository.dart';

class MonitorAppLifecycleUseCase {
  final IAppLifecycleRepository _repository;

  MonitorAppLifecycleUseCase(this._repository);

  Future<void> startMonitoring(String userId) async {
    await _repository.startMonitoring(userId);
  }

  Future<void> stopMonitoring(String userId) async {
    await _repository.stopMonitoring(userId);
  }

  Future<void> markOffline(String userId) async {
    await _repository.markOffline(userId);
  }
}
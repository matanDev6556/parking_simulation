import 'package:pumba_ex/data/services/app_lifecycle_service.dart';
import 'package:pumba_ex/domain/repositories/i_app_lifecycle_repository.dart';

class AppLifecycleRepository implements IAppLifecycleRepository {
  final AppLifecycleService _lifecycleService;

  AppLifecycleRepository(this._lifecycleService);

  @override
  Future<void> startMonitoring(String userId) async {
    await _lifecycleService.startHeartbeat(userId);
  }

  @override
  Future<void> stopMonitoring(String userId) async {
    _lifecycleService.stopHeartbeat();
  }

  @override
  Future<void> markOffline(String userId) async {
    await _lifecycleService.markUserOffline(userId);
  }
}